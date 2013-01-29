From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 0/2] ARM: update cpuinfo to print CPU model name
Date: Tue, 29 Jan 2013 10:02:44 -0600
Message-ID: <20130129160243.GA3389@kahuna>
References: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, eduardo.valentin@ti.com
List-Id: linux-omap@vger.kernel.org

On 17:54-20130129, Ruslan Bilovol wrote:
> Hi,
> 
> The following patches update cpuinfo to print CPU
> model name for ARM. First patch exactly makes needed
> changes for ARM architecture.
> Second patch adds this ability to OMAP4 SoCs.
> 
> This adds a common approach to show SoC name.
> 
> Looks like there were few attempts to do similar
> changes to cpuinfo without any luck.
> 
> So - comments are welcome
> 
> Ruslan Bilovol (2):
>   ARM: kernel: update cpuinfo to print CPU model name
>   ARM: OMAP4: setup CPU model name during ID initialisation

We had an discussion on similar lines but a generic suggestion:
https://patchwork.kernel.org/patch/98720/
SoCinfo framework which was supposed to introduce this

Would'nt that be a better approach to take than an OMAP only solution?

Ccying eduardo who had driven this for some time.
-- 
Regards,
Nishanth Menon
