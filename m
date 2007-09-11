From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH v2] Move the definition of pr_err() into kernel.h
Date: Tue, 11 Sep 2007 15:56:33 -0400
Message-ID: <31e679430709111256o212be3e4tcefb6decf2e136e0@mail.gmail.com>
References: <11895344211267-git-send-email-Emilian.Medve@Freescale.com>
	 <D5C1322C3E673F459512FB59E0DDC32903925779@orsmsx414.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <D5C1322C3E673F459512FB59E0DDC32903925779@orsmsx414.amr.corp.intel.com>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: "Waskiewicz Jr, Peter P" <peter.p.waskiewicz.jr@intel.com>
Cc: Emil Medve <Emilian.Medve@freescale.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, i2c@lm-sensors.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 9/11/07, Waskiewicz Jr, Peter P <peter.p.waskiewicz.jr@intel.com> wrote:
<snip>

> > -#define pr_err(fmt, arg...)  printk(KERN_ERR DRIVER_NAME ":
> > ", ## arg);
> > -
>
> Unnecessary whitespace removal.

Actually... I prefer removing the extra blank-line... it's easier to
read and keeps on blank-line only to separate other
defines/code-portion

Same to all the others

<snip><snip><snip><snip><snip>

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
