From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 07/13] OMAPDSS: HDMI: Add a get_timing function for
 HDMI interface
Date: Tue, 14 Aug 2012 22:46:52 +0530
Message-ID: <502A8804.5080101@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>   <1344512989-4071-1-git-send-email-archit@ti.com>   <1344512989-4071-8-git-send-email-archit@ti.com>  <1344949348.4845.46.camel@lappyti> <502A4F62.5050400@ti.com> <1344953420.4845.72.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44153 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640Ab2HNRQz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 13:16:55 -0400
In-Reply-To: <1344953420.4845.72.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tuesday 14 August 2012 07:40 PM, Tomi Valkeinen wrote:
> On Tue, 2012-08-14 at 18:45 +0530, Archit Taneja wrote:
>> On Tuesday 14 August 2012 06:32 PM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On Thu, 2012-08-09 at 17:19 +0530, Archit Taneja wrote:
>>>> Add function omapdss_hdmi_display_get_timing() which returns the timings
>>>> maintained by the HDMI interface driver in it's hdmi_config field. This
>>>> prevents the need for the panel driver to configure default timings in it's
>>>> probe.
>>>>
>>>> This function is just intended to be used once during the panel driver's probe.
>>>> It makes sense for those interfaces which can be configured to a default timing.
>>>
>>> I'm not sure about this patch. So I think the basic idea here is that
>>> HDMI will use VGA video mode if, for whatever reason, no better mode is
>>> found out.
>>>
>>> After this change, the panel driver doesn't seem to do that. Instead it
>>> uses whatever mode was used previously by the hdmi output driver.
>>>
>>> Is the only reason for this patch to clean up the hdmi_panel driver? We
>>> could have a dss helper function which returns the timings for VGA
>>> (well, just a public const variable would be enough), and the panel
>>> driver could use that to initialize the timings struct.
>>
>> Yes, that's the only reason, basically, to sync the panel with the
>> timings to which the hdmi output driver configured itself during it's
>> probe. We don't use hdmi_get_timing anywhere apart from here.
>
> Does the hdmi output driver even need to configure any defaults?
> Wouldn't it be ok to presume that the panel driver configures the
> timings?
>
> I don't think it's sensible to think about default values in the output
> driver generally (well, at least for things like timings). Although in
> HDMI's case VGA is quite sensible default, but that's not the case for
> any other output.
>
> So I think generally we should just trust the panel driver to tell the
> output driver what configuration should be used before the panel driver
> enables the output.
>
> That said, it doesn't hurt that the output drivers initialize their own
> datastructures to something relatively sane to avoid any BUG() or WARN()
> calls in the omapdss. Although we could also somehow track if the
> timings has been set, and return an error when enabling the display if
> timings hasn't been set. But that requires an extra flag, so perhaps
> it's simpler to have some initial values in the output driver also.
>
>> I thought it would be clean to retrieve the timings by taking whatever
>> is stored in the hdmi output driver, but we could leave it to a
>> hardcoded VGA as before.
>
> My main worry is that it's not easily clear what is going on if you look
> at the panel code. It looks that the panel just uses whatever is in the
> output driver. It's not clear that it is always VGA. What if the
> previous mode was something else?
>
> I think it's much clearer if the panel driver sets the timings
> explicitly before enabling the output. It doesn't have to be in panel's
> probe, although that's perhaps the easiest place for it.
>
>> I have done the same for venc, let me know if you think these should be
>> removed.
>
> Well, I agree that the initial timings code in hdmi and venc is a bit
> ugly. I don't think it's bad as such, just that the timings are standard
> ones, and instead of having all the timings numbers there, we should
> have a common place for them.

Okay, I'll remove the get_timing ops, keep defaults in the panel 
driver's probe, have a const variable for the defaults to make it look 
less ugly, and make sure that there is a set_timings for the output in 
the hdmi and venc panel drivers before they are enabled, it sort of okay 
for hdmi and venc panel drivers as there is going to be only one of them 
and be in our control.

Archit
