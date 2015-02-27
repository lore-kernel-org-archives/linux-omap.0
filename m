From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 4/8] ARM OMAP2+ GPMC: change get_gpmc_timing_reg output
 for DTS
Date: Fri, 27 Feb 2015 15:17:18 +0100
Message-ID: <CAMdRc4GO=FyELKkPgkL5W77MBh+CHWJ7GbEJdWU2LONLMrLTCA@mail.gmail.com>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424961956-29353-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<54EF366A.2050108@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EF366A.2050108@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: balbi@ti.com, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 26, 2015 at 4:06 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>    Documentation/kernel-doc-nano-HOWTO.txt requires colons after the
> parameter names, doesn't it?

Jesus Christ, you guys are killing me...
I've already spent way more time on this patch series than I intended
to anyway...

>> +       mask = (1 << nr_bits) - 1;
>
>
>    BIT(nr_bits) - 1, perhaps?

Not happening... BIT macro obscures what's actually going on.

Regards,

Robert
