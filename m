From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH-V2 1/3] RTC:s35390a: Add Alarm interrupt support
Date: Sat, 21 Aug 2010 17:05:41 +0300
Message-ID: <20100821140541.GA31697@nokia.com>
References: <hvaibhav@ti.com>
 <1282393829-7326-2-git-send-email-hvaibhav@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49287 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab0HUOGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Aug 2010 10:06:15 -0400
Content-Disposition: inline
In-Reply-To: <1282393829-7326-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "byron.bbradley@gmail.com" <byron.bbradley@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>

Hi,

On Sat, Aug 21, 2010 at 02:30:27PM +0200, ext hvaibhav@ti.com wrote:
>+static irqreturn_t s35390a_irq_thread(int irq, void *handle)
>+{
>+	char buf[1];
>+	struct s35390a *s35390a = handle;
>+	struct i2c_client *client = s35390a->client[0];

don't you need some locking on the irq handler ? a mutex maybe ? Just 
wondering...

>@@ -261,15 +424,30 @@ static int s35390a_probe(struct i2c_client *client,
> 	if (s35390a_get_datetime(client, &tm) < 0)
> 		dev_warn(&client->dev, "clock needs to be set\n");
>
>+	if (client->irq >= 0) {
>+		err = request_threaded_irq(client->irq, NULL,
>+				s35390a_irq_thread,
>+				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>+				client->name, s35390a);
>+		if (err) {
>+			dev_err(&client->dev, "unable to request IRQ\n");
>+			goto exit_dummy;
>+		}
>+	}
>+
> 	s35390a->rtc = rtc_device_register(s35390a_driver.driver.name,
> 				&client->dev, &s35390a_rtc_ops, THIS_MODULE);
>
> 	if (IS_ERR(s35390a->rtc)) {
> 		err = PTR_ERR(s35390a->rtc);
>-		goto exit_dummy;
>+		goto exit_intr;
> 	}
>+
> 	return 0;
>
>+exit_intr:
>+	free_irq(client->irq, client);

free_irq() won't behave correctly, I believe since you're passing 
different dev_id parameters. If you look at the implementation of 
free_irq() you'll see it uses dev_id to find the correct struct 
irqaction pointer.

-- 
balbi

DefectiveByDesign.org
