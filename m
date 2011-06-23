From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: Re: [RFC PATCHv5 4/7] HSI: hsi_char: Add HSI char device driver
Date: Thu, 23 Jun 2011 12:12:58 +0300
Message-ID: <1308820378.27256.2773.camel@groo>
References: <1307713124-3946-5-git-send-email-carlos.chinea@nokia.com>
	 <1308771464-15980-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308771464-15980-1-git-send-email-sjur.brandeland@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Sjur =?ISO-8859-1?Q?Br=E6ndeland?= <sjur.brandeland@stericsson.com>
Cc: sjurbren@gmail.com, Andras Domokos <andras.domokos@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, 2011-06-22 at 21:37 +0200, ext Sjur Br=C3=A6ndeland wrote:
> Hi Carlos,
>=20
> ...
> >+static ssize_t hsc_read(struct file *file, char __user *buf, size_t=
 len,
> >+						loff_t *ppos __maybe_unused)
> >+{
> ...
> >+	ret =3D hsi_async_read(channel->cl, msg);
> >+
> >+	ret =3D wait_event_interruptible(channel->rx_wait,
> >+					!list_empty(&channel->rx_msgs_queue));
> ...
>=20
> >+}
> >+
> >+static ssize_t hsc_write(struct file *file, const char __user *buf,=
 size_t len,
> >+						loff_t *ppos __maybe_unused)
> >+{
> >+	ret =3D hsi_async_write(channel->cl, msg);
> >+	if (ret < 0)
> >+		goto out;
> >+
> >+	ret =3D wait_event_interruptible(channel->tx_wait,
> >+					!list_empty(&channel->tx_msgs_queue));
>=20
> I would really like to see support for non-blocking read/write operat=
ion here.
>=20

Non-blocking support will not be supported in hsi_char.

> ...
> >+
> >+static const struct file_operations hsc_fops =3D {
> >+	.owner		=3D THIS_MODULE,
> >+	.read		=3D hsc_read,
> >+	.write		=3D hsc_write,
> >+	.unlocked_ioctl	=3D hsc_ioctl,
> >+	.open		=3D hsc_open,
> >+	.release	=3D hsc_release,
> >+};
>=20
> No poll?

We did have some "kind" of support for poll in previous versions, but w=
e
did not honor properly the poll expected behavior, as we always need to
"block" waiting for the complete callback to be called. At least for
reads this was an issue.

However to compensate this, we are planning to add AIO support in the
future, which maps a lot better into the hsi behavior.

> Currently we do bulk read/write operations upon modem-crash or firmwa=
re upload,
> and would perfeer to be able do asynchronous IO (select/poll) in orde=
r to
> receive other system events or timeouts during HSI bulk transfers.
>=20


Br,
--=20
Carlos Chinea <carlos.chinea@nokia.com>
