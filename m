From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/10] omap1: Fix DSP public peripherals support for
	ams-delta
Date: Fri, 23 Oct 2009 12:19:40 -0700
Message-ID: <20091023191939.GJ16230@atomide.com>
References: <20091022221013.27408.443.stgit@localhost> <20091022221216.27408.39863.stgit@localhost> <4AE0E938.7080305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753072AbZJWTTm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AE0E938.7080305@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

* Jon Hunter <jon-hunter@ti.com> [091022 16:22]:
>
> Tony Lindgren wrote:
>> From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>>
>> DSP public peripherals used to work on OMAP1510 based (or all OMAP1 class?)
>> machines as long as old dspgateway code were present in the l-o tree. For
>> several months it is no longer included, breaking support for McBSP1 based
>> audio on Amstrad Delta, for example.
>>
>> This patch, derived from the old dspgateway code, corrects the problem for the
>> board by simply taking the DSP out of reset state, I guess. That way, things
>> should not break when a new dsp code is added to the tree, and the change can
>> be reverted then.
>
> A minor comment/correction here. Although this bit is called "DSP_RST"  
> this does not actually release the DSP from reset. This bit actually  
> releases the reset for the "priority registers (TIPB module), EMIF  
> configuration registers, and the MPUI control logic (partially) in the  
> DSP", thus allowing you to access the DSP peripherals via the MPUI. Bit  
> 1 of the same register, called "DSP_EN", actually releases the DSP reset.

Thanks for clarifying that.

>> If there are any reports on McBSP1 or other DSP public peripherals not working
>> for other OMAP1 machines (I've not heard of any for now), I can prepare a more
>> general patch providing an extra include file with a helper function defined.
>
> This would be necessary for all OMAP15xx based devices that use McBSP1  
> (or McBSP3 for that matter). However, I am not sure if it is common for  
> other boards to use McBSP1 for audio.

Yeah, I guess currently only board-ams-delta.c needs this for audio.
But that could of course change once there are more 15xx boards using ASoC.

Regards,

Tony
