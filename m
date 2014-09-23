From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 3/4] tty: omap-serial: use threaded interrupt handler
Date: Tue, 23 Sep 2014 22:02:42 +0200
Message-ID: <CAH6sp9OLFdFbEa+RA07RWd_EzTbCz7p0HApSoTeSp28yA8FLrA@mail.gmail.com>
References: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
	<1410789610-23059-4-git-send-email-frans.klaver@xsens.com>
	<54170823.7040801@hurleysoftware.com>
	<5417228C.5070503@hurleysoftware.com>
	<20140916085037.GI28458@ci00147.xsens-tech.local>
	<54197804.3020302@hurleysoftware.com>
	<20140917121303.GB20438@ci00147.xsens-tech.local>
	<20140923082445.GA16218@ci00147.xsens-tech.local>
	<5421AB20.8040606@hurleysoftware.com>
	<88924386-79bc-44c7-9a07-249900cbd359@email.android.com>
	<20140923183838.GA3122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140923183838.GA3122@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Frans Klaver <frans.klaver@xsens.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Alexey Pelykh <alexey.pelykh@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 23, 2014 at 8:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Frans Klaver <fransklaver@gmail.com> [140923 11:12]:
>> On 23 September 2014 19:17:20 CEST, Peter Hurley <peter@hurleysoftware.com> wrote:
>> >
>> >I would've thought the first 2 patches had already been picked up
>> >because
>> >they fix div-by-zero faults.
>>
>> I've had no confirmation of that happening so far. I also don't
>> know if I should expect one. Who'd take these patches? Tony?
>
> $ scripts/get_maintainer.pl -f drivers/tty/serial/omap-serial.c
>
> Shows they should be sent to Greg and linux-serial. Please also Cc
> linux-omap. And if it's a fix, please make sure the subject has the
> magic word fix :)

Done. Thanks.

Frans
