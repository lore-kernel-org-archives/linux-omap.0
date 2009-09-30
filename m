From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] I2C: OMAP3: PM: (re)init for every transfer to support
	off-mode
Date: Wed, 30 Sep 2009 15:06:09 -0700
Message-ID: <636c5030909301506p7da5f016m5148ce6cd279e704@mail.gmail.com>
References: <1248217743-24330-1-git-send-email-khilman@deeprootsystems.com>
	 <20090729234308.GA8850@fluff.org.uk>
	 <4A7760A4.3080109@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f191.google.com ([209.85.222.191]:65317 "EHLO
	mail-pz0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbZI3WGG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 18:06:06 -0400
In-Reply-To: <4A7760A4.3080109@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Aug 3, 2009 at 3:11 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Ben Dooks wrote:
>>
>> On Tue, Jul 21, 2009 at 04:09:03PM -0700, Kevin Hilman wrote:
>>>
>>> From: Rajendra Nayak <rnayak@ti.com>
>>>
>>> Because of OMAP off-mode, powerdomain can go off when I2C is idle.
>>> Save enough state, and do a re-init for each transfer.
>>>
>>> Additional save/restore state added by Jagadeesh Bhaskar Pakaravoor
>>> (SYSC_REG) and Aaro Koskinen (wakeup sources.)
>>>
>>> Also, The OMAP3430 TRM states:
>>>
>>> "During active mode (I2Ci.I2C_CON[15] I2C_EN bit is set to 1), make=
 no
>>> changes to the I2Ci.I2C_SCLL and I2Ci.I2C_SCLH registers. =A0Change=
s may
>>> result in unpredictable behavior."
>>>
>>> Hence, the I2C_EN bit should be clearer when modifying these
>>> registers. Please note that clearing the entire I2C_CON register to
>>> disable the I2C module is safe, because the I2C_CON register is
>>> re-configured for each transfer.
>>
>> should this be applied as a bugfix, or kept for next merge window?
>
> next merge window is fine.
>

Ben,

It doesn't look like this made it in during the 2.6.32 merge window.
Can you queue it for the -rc series?

Kevin

>>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> Cc: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>>> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
>>> Cc: Jon Hunter <jon-hunter@ti.com>
>>> Cc: Hu Tao <taohu@motorola.com>
>>> Cc: Xiaolong Chen <A21785@motorola.com>
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>> ---
>>> This patch has been tested extensively as part of the OMAP 'PM bran=
ch'
>>>
>>> =A0drivers/i2c/busses/i2c-omap.c | =A0 64
>>> ++++++++++++++++++++++++++--------------
>>> =A01 files changed, 41 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-omap.c
>>> b/drivers/i2c/busses/i2c-omap.c
>>> index ad8d201..bb8ae50 100644
>>> --- a/drivers/i2c/busses/i2c-omap.c
>>> +++ b/drivers/i2c/busses/i2c-omap.c
>>> @@ -178,6 +178,12 @@ struct omap_i2c_dev {
>>> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0b_hw:1; =A0 =
=A0 =A0 =A0 /* bad h/w fixes */
>>> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0idle:1;
>>> =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iestate;=
 =A0 =A0 =A0 =A0/* Saved interrupt
>>> register */
>>> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pscstate;
>>> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scllstate=
;
>>> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sclhstate=
;
>>> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bufstate;
>>> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscstate=
;
>>> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 westate;
>>> =A0};
>>> =A0=A0static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2=
c_dev,
>>> @@ -230,9 +236,18 @@ static void omap_i2c_unidle(struct omap_i2c_de=
v
>>> *dev)
>>> =A0 =A0 =A0 =A0 =A0clk_enable(dev->iclk);
>>> =A0 =A0 =A0 =A0clk_enable(dev->fclk);
>>> + =A0 =A0 =A0 if (cpu_is_omap34xx()) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_=
REG, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_PSC_=
REG, dev->pscstate);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLL=
_REG,
>>> dev->scllstate);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLH=
_REG,
>>> dev->sclhstate);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_BUF_=
REG, dev->bufstate);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SYSC=
_REG,
>>> dev->syscstate);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_WE_R=
EG, dev->westate);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_=
REG,
>>> OMAP_I2C_CON_EN);
>>> + =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0dev->idle =3D 0;
>>> - =A0 =A0 =A0 if (dev->iestate)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_IE_R=
EG, dev->iestate);
>>> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate=
);
>>> =A0}
>>> =A0=A0static void omap_i2c_idle(struct omap_i2c_dev *dev)
>>> @@ -258,7 +273,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *=
dev)
>>> =A0=A0static int omap_i2c_init(struct omap_i2c_dev *dev)
>>> =A0{
>>> - =A0 =A0 =A0 u16 psc =3D 0, scll =3D 0, sclh =3D 0;
>>> + =A0 =A0 =A0 u16 psc =3D 0, scll =3D 0, sclh =3D 0, buf =3D 0;
>>> =A0 =A0 =A0 =A0u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh=
 =3D 0;
>>> =A0 =A0 =A0 =A0unsigned long fclk_rate =3D 12000000;
>>> =A0 =A0 =A0 =A0unsigned long timeout;
>>> @@ -287,24 +302,22 @@ static int omap_i2c_init(struct omap_i2c_dev =
*dev)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 SYSC_AUTOIDLE_MASK);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (dev->rev >=3D OMAP_I2=
C_REV_ON_3430) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 v;
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D SYSC_AUTOIDLE_M=
ASK;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v |=3D SYSC_ENAWAKEUP=
_MASK;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v |=3D (SYSC_IDLEMODE=
_SMART <<
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate =3D SY=
SC_AUTOIDLE_MASK;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate |=3D S=
YSC_ENAWAKEUP_MASK;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate |=3D (=
SYSC_IDLEMODE_SMART <<
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ffs(SY=
SC_SIDLEMODE_MASK));
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v |=3D (SYSC_CLOCKACT=
IVITY_FCLK <<
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate |=3D (=
SYSC_CLOCKACTIVITY_FCLK <<
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ffs(SY=
SC_CLOCKACTIVITY_MASK));
>>> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg=
(dev, OMAP_I2C_SYSC_REG, v);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(de=
v, OMAP_I2C_SYSC_REG,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->syscstate);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Enabling all waku=
p sources to stop I2C freezing
>>> on
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * WFI instruction.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * REVISIT: Some wku=
p sources might not be needed.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(de=
v, OMAP_I2C_WE_REG,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_I2C_WE_ALL);
>>> -
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->westate =3D OMAP=
_I2C_WE_ALL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(de=
v, OMAP_I2C_WE_REG,
>>> dev->westate);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>>> @@ -394,23 +407,28 @@ static int omap_i2c_init(struct omap_i2c_dev =
*dev)
>>> =A0 =A0 =A0 =A0omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
>>> =A0 =A0 =A0 =A0omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
>>> =A0- =A0 =A0 =A0 if (dev->fifo_size)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Note: setup required fifo size - 1=
 */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_BUF_=
REG,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (dev->fifo_size - 1) << 8 | /*
>>> RTRSH */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_I2C_BUF_RXFIF_CLR |
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (dev->fifo_size - 1) | /* XTRSH
>>> */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_I2C_BUF_TXFIF_CLR);
>>> + =A0 =A0 =A0 if (dev->fifo_size) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Note: setup required fifo size - 1=
=2E RTRSH and XTRSH */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf =3D (dev->fifo_size - 1) << 8 | O=
MAP_I2C_BUF_RXFIF_CLR
>>> |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dev->fifo_size - 1) =
| OMAP_I2C_BUF_TXFIF_CLR;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_BUF_=
REG, buf);
>>> + =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0/* Take the I2C module out of reset: */
>>> =A0 =A0 =A0 =A0omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_C=
ON_EN);
>>> =A0 =A0 =A0 =A0 =A0/* Enable interrupts */
>>> - =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP_I2C_IE_XRDY | O=
MAP_I2C_IE_RRDY |
>>> + =A0 =A0 =A0 dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY=
 |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_I2C_IE_ARDY | O=
MAP_I2C_IE_NACK |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_I2C_IE_AL) =A0|=
 ((dev->fifo_size) ?
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP=
_I2C_IE_RDR | OMAP_I2C_IE_XDR) :
>>> 0));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP=
_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
>>> + =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate=
);
>>> + =A0 =A0 =A0 if (cpu_is_omap34xx()) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->pscstate =3D psc;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->scllstate =3D scll;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->sclhstate =3D sclh;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->bufstate =3D buf;
>>> + =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>>
>>> --
>>> 1.6.3.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-i2c=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
