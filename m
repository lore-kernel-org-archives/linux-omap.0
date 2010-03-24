From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Wed, 24 Mar 2010 14:18:36 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CADC2E70@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
	 <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
	 <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
	 <94a0d4531003190918v7e943d5ax16baf6945472530c@mail.gmail.com>
	 <94a0d4531003191200r425652c3ybf505c353b2ad847@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CACBD655@dlee06.ent.ti.com>
	 <94a0d4531003191511q6135a424r9ce68c632cc826dd@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CACBD669@dlee06.ent.ti.com>
	 <496565EC904933469F292DDA3F1663E602CACBDF08@dlee06.ent.ti.com>
 <94a0d4531003241115i7b11af8cqb00b478afeb86297@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46778 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab0CXTSm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 15:18:42 -0400
In-Reply-To: <94a0d4531003241115i7b11af8cqb00b478afeb86297@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>


Hi Felipe,

>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Wednesday, March 24, 2010 12:15 PM
>To: Guzman Lugo, Fernando
>Cc: Hebbar, Shivananda; linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya
>Palande; felipe.contreras@nokia.com
>Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
>
>On Tue, Mar 23, 2010 at 9:29 PM, Guzman Lugo, Fernando <x0095840@ti.com>
>wrote:
>> I have tested just using an application (base on bridged code) which is
>registered for fatal events and once it receives an event it prints the
>received event:
>
>Ok, I ran your test and it works, however, I tried to modify it to fit
>what I'm doing in gst-dsp and it turns out it's very easy for this
>code to reboot the device. I'm attaching the test.
>
>Also, I found the exact reason why my code fails but yours not. I do
>something like this:
>
>while (!done) {
>  dsp_wait_for_events(&index);
>
>  if (index == 0) {
>    /* node message */
>    while (true) {
>      if (!dsp_node_get_message(&msg))
>        break;
>      handle_message(msg);
>    }
>  }
>}
>
>So, before your patch, the get_message() failed, and the next
>wait_for_events() succeeded and returned the MMU fault. Now, the
>get_message() fails, and so does the wait_for_events().

The think is that the now after fatal error and recovery process start all bridge ioctl's will fail with -EIO (that was the requirement when I did the code)

@@ -496,6 +553,12 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 	union Trapped_Args buf_in;
 
 	DBC_REQUIRE(filp != NULL);
+#ifdef CONFIG_BRIDGE_RECOVERY
+	if (recover) {
+		status = -EIO;
+		goto err;
+	}
+#endif

So you if you call dsp_node_get_message and then a fatal error happens, dsp_node_get_message will failed and if you what to call dsp_wait_for_events will fail because we are in recovery process (before it was succeeded because wait_for_events ioctl can go through and the MMUFault event was already signaled).

To sum up:
With this patch in order to be notified of fatal errors you need to register for those and call dsp_wait_for_events before the fatal error occurs. Otherwise dsp_wait_for_events will fail.

So I think you need a dedicate thread to receive fatal errors.

Regards,
Fernando.
>
>The only way to make that code work with your patch is to remove the
>inner while, so wait_for_events() and get_message() are always run one
>after the other.
>
>That is breaking old behavior and should be fixed, right?
>
>--
>Felipe Contreras
