From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] tty: omap-serial: use threaded interrupt handler
Date: Tue, 23 Sep 2014 11:38:38 -0700
Message-ID: <20140923183838.GA3122@atomide.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <88924386-79bc-44c7-9a07-249900cbd359@email.android.com>
Sender: linux-serial-owner@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Frans Klaver <frans.klaver@xsens.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Alexey Pelykh <alexey.pelykh@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Frans Klaver <fransklaver@gmail.com> [140923 11:12]:
> On 23 September 2014 19:17:20 CEST, Peter Hurley <peter@hurleysoftware.com> wrote:
> >
> >I would've thought the first 2 patches had already been picked up
> >because
> >they fix div-by-zero faults.
> 
> I've had no confirmation of that happening so far. I also don't
> know if I should expect one. Who'd take these patches? Tony? 

$ scripts/get_maintainer.pl -f drivers/tty/serial/omap-serial.c

Shows they should be sent to Greg and linux-serial. Please also Cc
linux-omap. And if it's a fix, please make sure the subject has the
magic word fix :)

Regards,

Tony
