From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: Change all cpu_is_* occurences to soc_is_*
Date: Tue, 1 Sep 2015 11:03:47 -0700
Message-ID: <20150901180347.GO4215@atomide.com>
References: <1440561575-3740-1-git-send-email-j-keerthy@ti.com>
 <55E5DE12.6070407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E5DE12.6070407@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

* Keerthy <a0393675@ti.com> [150901 10:22]:
> 
> 
> On Wednesday 26 August 2015 09:29 AM, Keerthy wrote:
> >Currently apart from dra7, omap5 and amx3 all the other SoCs
> >are identified using cpu_is_* functions which is not right since
> >they are all SoCs(System on Chips). Hence changing the SoC
> >identification code to use soc_is instead of cpu_is and keeping
> >defines for cpu_is where needed. This allows us to replace the
> >rest of cpu_is usage along with other fixes as needed.
> 
> Tony,
> 
> A Gentle ping on this.

Looks good to me for v4.4. I'll apply it after some testing
after -rc1.

Regards,

Tony
