From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 3/3] radio-tea5761: Update driver
Date: Tue, 10 Jun 2008 13:42:12 -0400
Message-ID: <1213119732-13198-4-git-send-email-edubezval@gmail.com>
References: <1213119732-13198-1-git-send-email-edubezval@gmail.com>
 <1213119732-13198-2-git-send-email-edubezval@gmail.com>
 <1213119732-13198-3-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40469 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbYFJRnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 13:43:00 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5AHguZL012642
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 20:42:57 +0300
In-Reply-To: <1213119732-13198-3-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch updates this driver by changing the way it accesses
the device. There is the tuner API which already has an implementation
for tea5761.

This patch changes the driver to use tuner API.

It also changes the way ioctls are handled. This way
it is more easy to deal with v4l2 and v4l calls.

Some cleans are also done.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/radio/Kconfig         |    1 +
 drivers/media/radio/Makefile        |    2 +
 drivers/media/radio/radio-tea5761.c |  570 +++++++++++++++++------------------
 3 files changed, 278 insertions(+), 295 deletions(-)

diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index de6ca27..b45f834 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -341,6 +341,7 @@ config RADIO_ZOLTRIX_PORT
 
 config RADIO_TEA5761
 	tristate "Philips Semiconductors TEA5761 I2C FM Radio"
+	depends on MEDIA_TUNER_TEA5761
 	help
 	  Choose Y here if you have one of these AM/FM radio cards.
 
diff --git a/drivers/media/radio/Makefile b/drivers/media/radio/Makefile
index f5bffcc..a843007 100644
--- a/drivers/media/radio/Makefile
+++ b/drivers/media/radio/Makefile
@@ -25,3 +25,5 @@ obj-$(CONFIG_USB_DSBR) += dsbr100.o
 obj-$(CONFIG_USB_SI470X) += radio-si470x.o
 
 EXTRA_CFLAGS += -Isound
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core/
+EXTRA_CFLAGS += -Idrivers/media/common/tuners/
diff --git a/drivers/media/radio/radio-tea5761.c b/drivers/media/radio/radio-tea5761.c
index e8ccf29..cc39a44 100644
--- a/drivers/media/radio/radio-tea5761.c
+++ b/drivers/media/radio/radio-tea5761.c
@@ -23,79 +23,29 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <media/v4l2-common.h>
+#include <media/tuner.h>
+
+#include "dvb_frontend.h"
+#include "tea5761.h"
 
 #define DRIVER_NAME "tea5761"
 
 #define TEA5761_VERSION		KERNEL_VERSION(0, 0, 1)
 
-#define TEA5761_I2C_ADDR	0x10
-
-#define TEA5761_MANID		0x002b
-#define TEA5761_CHIPID		0x5761
-
-#define TEA5761_INTREG_BLMSK	0x0001
-#define TEA5761_INTREG_FRRMSK	0x0002
-#define TEA5761_INTREG_LEVMSK	0x0008
-#define TEA5761_INTREG_IFMSK	0x0010
-#define TEA5761_INTREG_BLMFLAG	0x0100
-#define TEA5761_INTREG_FRRFLAG	0x0200
-#define TEA5761_INTREG_LEVFLAG	0x0800
-#define TEA5761_INTREG_IFFLAG	0x1000
-
-#define TEA5761_FRQSET_SUD	0x8000
-#define TEA5761_FRQSET_SM	0x4000
-
-#define TEA5761_TNCTRL_PUPD0	0x4000
-#define TEA5761_TNCTRL_BLIM	0x2000
-#define TEA5761_TNCTRL_SWPM	0x1000
-#define TEA5761_TNCTRL_IFCTC	0x0800
-#define TEA5761_TNCTRL_AFM	0x0400
-#define TEA5761_TNCTRL_SMUTE	0x0200
-#define TEA5761_TNCTRL_SNC	0x0100
-#define TEA5761_TNCTRL_MU	0x0080
-#define TEA5761_TNCTRL_SSL1	0x0040
-#define TEA5761_TNCTRL_SSL0	0x0020
-#define TEA5761_TNCTRL_HLSI	0x0010
-#define TEA5761_TNCTRL_MST	0x0008
-#define TEA5761_TNCTRL_SWP	0x0004
-#define TEA5761_TNCTRL_DTC	0x0002
-#define TEA5761_TNCTRL_AHLSI	0x0001
-
-#define TEA5761_TUNCHK_LEVEL(x)	(((x) & 0x00F0) >> 4)
-#define TEA5761_TUNCHK_IFCNT(x) (((x) & 0xFE00) >> 9)
-#define TEA5761_TUNCHK_TUNTO	0x0100
-#define TEA5761_TUNCHK_LD	0x0008
-#define TEA5761_TUNCHK_STEREO	0x0004
-
-#define TEA5761_TESTREG_TRIGFR	0x0800
-
 #define TEA5761_FREQ_LOW	87500
 #define TEA5761_FREQ_HIGH	108000
 
-struct tea5761_regs {
-	u16 intreg;
-	u16 frqset;
-	u16 tnctrl;
-	u16 frqchk;
-	u16 tunchk;
-	u16 testreg;
-	u16 manid;
-	u16 chipid;
-} __attribute__ ((packed));
-
-struct tea5761_write_regs {
-	u8 intreg;
-	u16 frqset;
-	u16 tnctrl;
-	u16 testreg;
-} __attribute__ ((packed));
-
 struct tea5761_device {
 	struct video_device	*video_dev;
-	struct i2c_client	*i2c_dev;
-	struct tea5761_regs	regs;
+	struct device		*dev;
+	struct dvb_frontend	fe;
+	/* To control number of users access (.users field) */
 	struct mutex		mutex;
 	int			users;
+	unsigned int		freq;
+	u16			audmode;
+	u8			mute;
+	u8			power;
 };
 
 static struct tea5761_device tea5761;
@@ -103,267 +53,286 @@ static struct tea5761_device tea5761;
 static struct i2c_driver	tea5761_driver;
 static int radio_nr = -1;
 
-static int tea5761_read_regs(struct tea5761_device *tea)
+static void tea5761_power_up(struct tea5761_device *tea)
 {
-	int rc, i;
-	u16 *p = (u16 *) &tea->regs;
-	struct i2c_client *client = tea->i2c_dev;
+	struct dvb_frontend *fe = &tea->fe;
+	struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
 
-	rc = i2c_master_recv(client, (void*) &tea->regs, sizeof(tea->regs));
-	for (i = 0; i < 8; i++) {
-		p[i] = __be16_to_cpu(p[i]);
-	}
+	if (fe_tuner_ops->init)
+		fe_tuner_ops->init(fe);
+	tea->power = 1;
+}
 
-	dev_dbg(&client->dev,
-		"chip state: %04x %04x %04x %04x %04x %04x %04x %04x\n",
-		p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
+static void tea5761_power_down(struct tea5761_device *tea)
+{
+	struct dvb_frontend *fe = &tea->fe;
+	struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
 
-	if (rc < 0)
-		dev_err(&client->dev, "read\n");
+	if (fe_tuner_ops->sleep)
+		fe_tuner_ops->sleep(fe);
+	tea->power = 0;
+}
 
-	return rc;
+static void tea5761_set_freq(struct tea5761_device *tea, unsigned int freq)
+{
+	struct dvb_frontend *fe = &tea->fe;
+	struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
+	struct analog_parameters params = {
+		.mode		= V4L2_TUNER_RADIO,
+		.audmode	= tea->audmode,
+		.frequency	= freq,
+	};
+
+	if (NULL == fe_tuner_ops->set_analog_params) {
+		dev_warn(tea->dev,
+			"Tuner frontend module has no way to set frequency\n");
+		return;
+	}
+	if (!fe_tuner_ops->set_analog_params(fe, &params))
+		tea->freq = freq;
 }
 
-static void tea5761_write_regs(struct tea5761_device *tea)
+static int tea5761_get_freq(struct tea5761_device *tea)
 {
-	struct tea5761_write_regs wr;
-	struct tea5761_regs *r = &tea->regs;
-	struct i2c_client *client = tea->i2c_dev;
-	u8 *p = (u8 *) r;
-
-	wr.intreg = r->intreg & 0xff;
-	wr.frqset = __cpu_to_be16(r->frqset);
-	wr.tnctrl = __cpu_to_be16(r->tnctrl);
-	wr.testreg = __cpu_to_be16(r->testreg);
-
-	dev_dbg(&client->dev,
-		"writing state: %02x %02x %02x %02x %02x %02x %02x\n",
-		p[0], p[1], p[2], p[3], p[4], p[5], p[6]);
-	if (i2c_master_send(client, (void *) &wr, sizeof(wr)) < 0)
-		dev_err(&client->dev, "write\n");
+	struct dvb_frontend *fe = &tea->fe;
+	struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
+	u32 freq;
+
+	if (fe_tuner_ops->get_frequency) {
+		fe_tuner_ops->get_frequency(fe, &freq);
+		return freq * 2 / 125;
+	}
+
+	return -ENODEV;
 }
 
-static void tea5761_power_up(struct tea5761_device *tea)
+static void tea5761_set_audout_mode(struct tea5761_device *tea, int audmode)
 {
-	struct tea5761_regs *r = &tea->regs;
-
-	if (!(r->tnctrl & TEA5761_TNCTRL_PUPD0)) {
-		r->tnctrl &= ~(TEA5761_TNCTRL_AFM | TEA5761_TNCTRL_MU |
-			       TEA5761_TNCTRL_HLSI);
-		r->testreg |= TEA5761_TESTREG_TRIGFR;
-		r->tnctrl |= TEA5761_TNCTRL_PUPD0;
-		return tea5761_write_regs(tea);
+	struct dvb_frontend *fe = &tea->fe;
+	struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
+	struct analog_parameters params = {
+		.mode		= V4L2_TUNER_RADIO,
+		.frequency	= tea->freq,
+		.audmode	= audmode,
+	};
+
+	if (NULL == fe_tuner_ops->set_analog_params) {
+		dev_warn(tea->dev,
+			"Tuner frontend module has no way to set frequency\n");
+		return;
 	}
+	if (!fe_tuner_ops->set_analog_params(fe, &params))
+		tea->audmode = audmode;
 }
 
-static void tea5761_power_down(struct tea5761_device *tea)
+static int tea5761_get_audout_mode(struct tea5761_device *tea)
 {
-	struct tea5761_regs *r = &tea->regs;
+	return tea->audmode;
+}
 
-	if (r->tnctrl & TEA5761_TNCTRL_PUPD0) {
-		r->tnctrl &= ~TEA5761_TNCTRL_PUPD0;
-		return tea5761_write_regs(tea);
+static void tea5761_mute(struct tea5761_device *tea, int on)
+{
+	struct dvb_frontend *fe = &tea->fe;
+	struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
+	struct analog_parameters params = {
+		.mode		= on ? T_STANDBY : V4L2_TUNER_RADIO,
+		.frequency	= tea->freq,
+		.audmode	= tea->audmode,
+	};
+
+	if (NULL == fe_tuner_ops->set_analog_params) {
+		dev_warn(tea->dev,
+			"Tuner frontend module has no way to set frequency\n");
+		return;
 	}
+	if (!fe_tuner_ops->set_analog_params(fe, &params))
+		tea->mute = on;
 }
 
-static void tea5761_set_freq(struct tea5761_device *tea, int freq)
+static int tea5761_is_muted(struct tea5761_device *tea)
 {
-	struct tea5761_regs *r = &tea->regs;
+	return tea->mute;
+}
 
-	if (r->tnctrl & TEA5761_TNCTRL_HLSI)
-		r->frqset = (freq + 225000) / 8192;
-	else
-		r->frqset = (freq - 225000) / 8192;
+static int tea5761_vidioc_querycap(struct file *file, void *priv,
+					struct v4l2_capability *c)
+{
+	struct tea5761_device *tea = file->private_data;
+	struct video_device *dev = tea->video_dev;
+
+	memset(c, 0, sizeof(*c));
+	strlcpy(c->driver, dev->dev->driver->name, sizeof(*c->driver));
+	strlcpy(c->card, dev->name, sizeof(c->card));
+	snprintf(c->bus_info, sizeof(c->bus_info), "I2C:%s",
+		dev->dev->bus_id);
+	c->version = TEA5761_VERSION;
+	c->capabilities = V4L2_CAP_TUNER | V4L2_CAP_RADIO;
+
+	return 0;
 }
 
-static int tea5761_get_freq(struct tea5761_device *tea)
+static int tea5761_vidioc_g_tuner(struct file *file, void *priv,
+					struct v4l2_tuner *t)
 {
-	struct tea5761_regs *r = &tea->regs;
+	struct tea5761_device *tea = file->private_data;
+	struct dvb_frontend *fe = &tea->fe;
+	u16 strength = 0;
 
-	if (r->tnctrl & TEA5761_TNCTRL_HLSI)
-		return (r->frqchk * 8192) - 225000;
-	else
-		return (r->frqchk * 8192) + 225000;
+	/* Only one tuner chip */
+	if (t->index != 0)
+		return -EINVAL;
+
+	memset(t, 0, sizeof(*t));
+	t->type = V4L2_TUNER_RADIO;
+	strlcpy(t->name, "FM", sizeof(t->name));
+	/* Frequency in 62.5Hz units */
+	t->rangelow = TEA5761_FREQ_LOW * 16;
+	t->rangehigh = TEA5761_FREQ_HIGH * 16;
+	t->capability = V4L2_TUNER_CAP_LOW | V4L2_TUNER_CAP_STEREO;
+
+	t->audmode = tea5761_get_audout_mode(tea);
+	if (t->audmode == V4L2_TUNER_MODE_STEREO)
+		t->rxsubchans = V4L2_TUNER_SUB_STEREO;
+
+	if (fe->ops.tuner_ops.get_rf_strength)
+		fe->ops.tuner_ops.get_rf_strength(fe, &strength);
+	t->signal = strength;
+
+	return 0;
 }
 
-static void tea5761_tune(struct tea5761_device *tea, int freq)
+static int tea5761_vidioc_s_tuner(struct file *file, void *priv,
+					struct v4l2_tuner *t)
 {
-	tea5761_set_freq(tea, freq);
-	tea5761_write_regs(tea);
+	struct tea5761_device *tea = file->private_data;
+
+	/* Only tuner number 0 can be selected. */
+	if (t->index != 0)
+		return -EINVAL;
+	tea5761_set_audout_mode(tea, t->audmode);
+
+	return 0;
 }
 
-static void tea5761_set_audout_mode(struct tea5761_device *tea, int audmode)
+static int tea5761_vidioc_g_frequency(struct file *file, void *priv,
+					struct v4l2_frequency *f)
 {
-	struct tea5761_regs *r = &tea->regs;
-	int tnctrl = r->tnctrl;
+	struct tea5761_device *tea = file->private_data;
 
-	if (audmode == V4L2_TUNER_MODE_MONO)
-		r->tnctrl |= TEA5761_TNCTRL_MST;
+	memset(f, 0, sizeof(*f));
+	f->type = V4L2_TUNER_RADIO;
+	if (tea->power)
+		f->frequency = (tea5761_get_freq(tea) * 2) / 125;
 	else
-		r->tnctrl &= ~TEA5761_TNCTRL_MST;
-	if (tnctrl != r->tnctrl)
-		tea5761_write_regs(tea);
+		f->frequency = 0;
+
+	return 0;
 }
 
-static int tea5761_get_audout_mode(struct tea5761_device *tea)
+static int tea5761_vidioc_s_frequency(struct file *file, void *priv,
+					struct v4l2_frequency *f)
 {
-	struct tea5761_regs *r = &tea->regs;
+	struct tea5761_device *tea = file->private_data;
 
-	if (r->tnctrl & TEA5761_TNCTRL_MST)
-		return V4L2_TUNER_MODE_MONO;
-	else
-		return V4L2_TUNER_MODE_STEREO;
+	if (f->tuner != 0)
+		return -EINVAL;
+	if (f->frequency == 0) {
+		/* We special case this as a power down
+		 * control. */
+		tea5761_power_down(tea);
+		return 0;
+	}
+	if (f->frequency < 16 * TEA5761_FREQ_LOW)
+		return -EINVAL;
+	if (f->frequency > 16 * TEA5761_FREQ_HIGH)
+		return -EINVAL;
+
+	tea5761_power_up(tea);
+	tea5761_set_freq(tea, f->frequency);
+
+	return 0;
 }
 
-static void tea5761_mute(struct tea5761_device *tea, int on)
+static int tea5761_vidioc_queryctrl(struct file *file, void *priv,
+					struct v4l2_queryctrl *qc)
 {
-	struct tea5761_regs *r = &tea->regs;
-	int tnctrl = r->tnctrl;
+	if (qc->id != V4L2_CID_AUDIO_MUTE)
+		return -EINVAL;
+	strlcpy(qc->name, "Mute", sizeof(qc->name));
+	qc->minimum = 0;
+	qc->maximum = 1;
+	qc->step = 1;
+	qc->default_value = 0;
+	qc->type = V4L2_CTRL_TYPE_BOOLEAN;
+
+	return 0;
+}
+
+static int tea5761_vidioc_g_ctrl(struct file *file, void *priv,
+					struct v4l2_control *ct)
+{
+	struct tea5761_device *tea = file->private_data;
 
-	if (on)
-		r->tnctrl |= TEA5761_TNCTRL_MU;
+	if (ct->id != V4L2_CID_AUDIO_MUTE)
+		return -EINVAL;
+	if (tea->power)
+		ct->value = tea5761_is_muted(tea) ? 1 : 0;
 	else
-		r->tnctrl &= ~TEA5761_TNCTRL_MU;
-	if (tnctrl != r->tnctrl)
-		tea5761_write_regs(tea);
+		ct->value = 0;
+
+	return 0;
 }
 
-static int tea5761_is_muted(struct tea5761_device *tea)
+static int tea5761_vidioc_s_ctrl(struct file *file, void *priv,
+				struct v4l2_control *ct)
 {
-	return tea->regs.tnctrl & TEA5761_TNCTRL_MU;
+	struct tea5761_device *tea = file->private_data;
+
+	if (ct->id != V4L2_CID_AUDIO_MUTE)
+		return -EINVAL;
+	tea5761_mute(tea, ct->value);
+
+	return 0;
 }
 
-static int tea5761_do_ioctl(struct inode *inode, struct file *file,
-			    unsigned int cmd, void *arg)
+static int tea5761_vidioc_g_audio(struct file *file, void *priv,
+					struct v4l2_audio *audio)
 {
 	struct tea5761_device *tea = file->private_data;
-	struct video_device *dev = tea->video_dev;
-	struct i2c_client *client = tea->i2c_dev;
-	struct tea5761_regs *r = &tea->regs;
-
-	union {
-		struct v4l2_capability c;
-		struct v4l2_tuner t;
-		struct v4l2_frequency f;
-		struct v4l2_queryctrl qc;
-		struct v4l2_control ct;
-	} *u = arg;
-
-	tea5761_read_regs(tea);
-
-	switch (cmd) {
-	case VIDIOC_QUERYCAP:
-		dev_dbg(&client->dev, "VIDIOC_QUERYCAP\n");
-		memset(&u->c, 0, sizeof(u->c));
-		strlcpy(u->c.driver, dev->dev->driver->name,
-			sizeof(u->c.driver));
-		strlcpy(u->c.card, dev->name, sizeof(u->c.card));
-		snprintf(u->c.bus_info, sizeof(u->c.bus_info), "I2C:%s",
-			 dev->dev->bus_id);
-		u->c.version = TEA5761_VERSION;
-		u->c.capabilities = V4L2_CAP_TUNER | V4L2_CAP_RADIO;
-		break;
-
-	case VIDIOC_G_TUNER:
-		/* Only one tuner chip */
-		dev_dbg(&client->dev, "VIDIOC_G_TUNER\n");
-		if (u->t.index != 0)
-			return -EINVAL;
-
-		memset(&u->t, 0, sizeof(u->t));
-		u->t.type = V4L2_TUNER_RADIO;
-		strlcpy(u->t.name, "FM", sizeof(u->t.name));
-		/* Freq in 62.5Hz units */
-		u->t.rangelow = TEA5761_FREQ_LOW * 16;
-		u->t.rangehigh = TEA5761_FREQ_HIGH * 16;
-		u->t.capability = V4L2_TUNER_CAP_LOW | V4L2_TUNER_CAP_STEREO;
-		if (r->tunchk & TEA5761_TUNCHK_STEREO)
-			u->t.rxsubchans = V4L2_TUNER_SUB_STEREO;
-		u->t.audmode = tea5761_get_audout_mode(tea);
-		u->t.signal = TEA5761_TUNCHK_LEVEL(r->tunchk) * 0xffff / 0xf;
-		u->t.afc = TEA5761_TUNCHK_IFCNT(r->tunchk);
-		break;
-
-	case VIDIOC_S_TUNER:
-		/* Only tuner nro 0 can be selected. */
-		dev_dbg(&client->dev, "VIDIOC_S_TUNER\n");
-		if (u->t.index != 0)
-			return -EINVAL;
-		tea5761_set_audout_mode(tea, u->t.audmode);
-		break;
-
-	case VIDIOC_G_FREQUENCY:
-		dev_dbg(&client->dev, "VIDIOC_G_FREQUENCY\n");
-		memset(&u->f, 0, sizeof(u->f));
-		u->f.type = V4L2_TUNER_RADIO;
-		if (r->tnctrl & TEA5761_TNCTRL_PUPD0)
-			u->f.frequency = (tea5761_get_freq(tea) * 2) / 125;
-		else
-			u->f.frequency = 0;
-		break;
-
-	case VIDIOC_S_FREQUENCY:
-		dev_dbg(&client->dev, "VIDIOC_S_FREQUENCY %u\n",
-			u->f.frequency);
-		if (u->f.tuner != 0)
-			return -EINVAL;
-		if (u->f.frequency == 0) {
-			/* We special case this as a power down
-			 * control. */
-			tea5761_power_down(tea);
-			break;
-		}
-		if (u->f.frequency < 16 * TEA5761_FREQ_LOW)
-			return -EINVAL;
-		if (u->f.frequency > 16 * TEA5761_FREQ_HIGH)
-			return -EINVAL;
-
-		tea5761_power_up(tea);
-		tea5761_tune(tea, (u->f.frequency * 125) / 2);
-		break;
-
-	case VIDIOC_QUERYCTRL:
-		dev_dbg(&client->dev, "VIDIOC_QUERYCTRL %d\n", u->qc.id);
-		if (u->qc.id != V4L2_CID_AUDIO_MUTE)
-			return -EINVAL;
-		strlcpy(u->qc.name, "Mute", sizeof(u->qc.name));
-		u->qc.minimum = 0;
-		u->qc.maximum = 1;
-		u->qc.step = 1;
-		u->qc.default_value = 0;
-		u->qc.type = V4L2_CTRL_TYPE_BOOLEAN;
-		break;
-
-	case VIDIOC_G_CTRL:
-		dev_dbg(&client->dev, "VIDIOC_G_CTRL %d\n", u->ct.id);
-		if (u->ct.id != V4L2_CID_AUDIO_MUTE)
-			return -EINVAL;
-		if (r->tnctrl & TEA5761_TNCTRL_PUPD0)
-			u->ct.value = tea5761_is_muted(tea) ? 1 : 0;
-		else
-			u->ct.value = 0;
-		break;
-
-	case VIDIOC_S_CTRL:
-		dev_dbg(&client->dev, "VIDIOC_S_CTRL %d\n", u->ct.id);
-		if (u->ct.id != V4L2_CID_AUDIO_MUTE)
-			return -EINVAL;
-		tea5761_mute(tea, u->ct.value);
-		break;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
+
+	strlcpy(audio->name, "FM Radio", ARRAY_SIZE(audio->name));
+	audio->mode = tea->audmode;
 
 	return 0;
 }
 
-static int tea5761_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, unsigned long arg)
+static int tea5761_vidioc_s_audio(struct file *file, void *priv,
+					struct v4l2_audio *audio)
 {
-	return video_usercopy(inode, file, cmd, arg, tea5761_do_ioctl);
+	struct tea5761_device *tea = file->private_data;
+
+	tea5761_set_audout_mode(tea,  audio->mode);
+
+	return 0;
 }
 
+static int tea5761_vidioc_g_input(struct file *filp, void *priv,
+		unsigned int *i)
+{
+	*i = 0;
+
+	return 0;
+}
+
+static int tea5761_vidioc_s_input(struct file *filp, void *priv, unsigned int i)
+{
+	if (i)
+		return -EINVAL;
+
+	return 0;
+}
+
+
 static int tea5761_open(struct inode *inode, struct file *file)
 {
 	int minor = iminor(file->f_dentry->d_inode);
@@ -401,16 +370,32 @@ static struct file_operations tea5761_fops = {
 	.owner		= THIS_MODULE,
 	.open           = tea5761_open,
 	.release	= tea5761_release,
-	.ioctl		= tea5761_ioctl,
 	.llseek         = no_llseek,
+	.ioctl		= video_ioctl2,
+	.compat_ioctl	= v4l_compat_ioctl32,
 };
 
+/*
+ * tea5761_viddev_tamples - video device interface
+ */
 static struct video_device tea5761_video_device = {
-	.owner         = THIS_MODULE,
-	.name          = "TEA5761 FM-Radio",
-	.type          = VID_TYPE_TUNER,
-	.fops          = &tea5761_fops,
-	.release       = video_device_release
+	.owner			= THIS_MODULE,
+	.name			= "TEA5761 FM-Radio",
+	.type			= VID_TYPE_TUNER,
+	.release		= video_device_release,
+	.fops			= &tea5761_fops,
+	.vidioc_querycap	= tea5761_vidioc_querycap,
+	.vidioc_g_tuner		= tea5761_vidioc_g_tuner,
+	.vidioc_s_tuner		= tea5761_vidioc_s_tuner,
+	.vidioc_g_frequency	= tea5761_vidioc_g_frequency,
+	.vidioc_s_frequency	= tea5761_vidioc_s_frequency,
+	.vidioc_queryctrl	= tea5761_vidioc_queryctrl,
+	.vidioc_g_ctrl		= tea5761_vidioc_g_ctrl,
+	.vidioc_s_ctrl		= tea5761_vidioc_s_ctrl,
+	.vidioc_g_audio		= tea5761_vidioc_g_audio,
+	.vidioc_s_audio		= tea5761_vidioc_s_audio,
+	.vidioc_g_input		= tea5761_vidioc_g_input,
+	.vidioc_s_input		= tea5761_vidioc_s_input,
 };
 
 static int tea5761_i2c_driver_probe(struct i2c_client *client,
@@ -422,12 +407,24 @@ static int tea5761_i2c_driver_probe(struct i2c_client *client,
 
 	mutex_init(&tea->mutex);
 
-	tea->i2c_dev = client;
+	/* Tuner attach */
+	if (!dvb_attach(tea5761_attach, &tea->fe, client->adapter,
+			client->addr)) {
+		dev_err(&client->dev, "Could not attach tuner\n");
+		err = -ENODEV;
+		goto exit;
+	}
+
+	/* initialize and power off the chip */
+	tea5761_power_up(tea);
+	tea5761_set_audout_mode(tea, V4L2_TUNER_MODE_STEREO);
+	tea5761_mute(tea, 0);
+	tea5761_power_down(tea);
 
 	/* V4L initialization */
 	video_dev = video_device_alloc();
 	if (video_dev == NULL) {
-		dev_err(&client->dev, "couldn't allocate memory\n");
+		dev_err(&client->dev, "Could not allocate memory\n");
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -436,25 +433,15 @@ static int tea5761_i2c_driver_probe(struct i2c_client *client,
 	*video_dev = tea5761_video_device;
 	video_dev->dev = &client->dev;
 	i2c_set_clientdata(client, video_dev);
-
-	/* initialize and power off the chip */
-	tea5761_read_regs(tea);
-	tea5761_set_audout_mode(tea, V4L2_TUNER_MODE_STEREO);
-	tea5761_mute(tea, 0);
-	tea5761_power_down(tea);
-
-	tea5761.video_dev = video_dev;
-	tea5761.i2c_dev = client;
+	tea->video_dev = video_dev;
+	tea->dev = &client->dev;
 
 	err = video_register_device(video_dev, VFL_TYPE_RADIO, radio_nr);
 	if (err) {
-		dev_err(&client->dev, "couldn't register video device\n");
+		dev_err(&client->dev, "Could not register video device\n");
 		goto err_video_alloc;
 	}
 
-	dev_info(&client->dev, "tea5761 (version %d) detected\n",
-		(tea->regs.manid >> 12) & 0xf);
-
 	return 0;
 
 err_video_alloc:
@@ -490,14 +477,7 @@ static struct i2c_driver tea5761_driver = {
 
 static int __init tea5761_init(void)
 {
-	int res;
-
-	if ((res = i2c_add_driver(&tea5761_driver))) {
-		printk(KERN_ERR DRIVER_NAME ": driver registration failed\n");
-		return res;
-	}
-
-	return 0;
+	return i2c_add_driver(&tea5761_driver);
 }
 
 static void __exit tea5761_exit(void)
-- 
1.5.6.rc0.84.g06f60.dirty

