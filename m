From: =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: Re: [RFC PATCHv5 4/7] HSI: hsi_char: Add HSI char device driver
Date: Wed, 22 Jun 2011 21:37:44 +0200
Message-ID: <1308771464-15980-1-git-send-email-sjur.brandeland@stericsson.com>
References: <1307713124-3946-5-git-send-email-carlos.chinea@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307713124-3946-5-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>, sjurbren@gmail.com
Cc: Andras Domokos <andras.domokos@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi Carlos,

...
>+static ssize_t hsc_read(struct file *file, char __user *buf, size_t len,
>+						loff_t *ppos __maybe_unused)
>+{
...
>+	ret = hsi_async_read(channel->cl, msg);
>+
>+	ret = wait_event_interruptible(channel->rx_wait,
>+					!list_empty(&channel->rx_msgs_queue));
...

>+}
>+
>+static ssize_t hsc_write(struct file *file, const char __user *buf, size_t len,
>+						loff_t *ppos __maybe_unused)
>+{
>+	ret = hsi_async_write(channel->cl, msg);
>+	if (ret < 0)
>+		goto out;
>+
>+	ret = wait_event_interruptible(channel->tx_wait,
>+					!list_empty(&channel->tx_msgs_queue));

I would really like to see support for non-blocking read/write operation here.

...
>+
>+static const struct file_operations hsc_fops = {
>+	.owner		= THIS_MODULE,
>+	.read		= hsc_read,
>+	.write		= hsc_write,
>+	.unlocked_ioctl	= hsc_ioctl,
>+	.open		= hsc_open,
>+	.release	= hsc_release,
>+};

No poll?
Currently we do bulk read/write operations upon modem-crash or firmware upload,
and would perfeer to be able do asynchronous IO (select/poll) in order to
receive other system events or timeouts during HSI bulk transfers.

Regards,
Sjur
