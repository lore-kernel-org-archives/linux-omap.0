From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Broken DM816x support in Linux 3.10-rc4
Date: Thu, 6 Jun 2013 08:55:41 -0700
Message-ID: <20130606155541.GM3331@atomide.com>
References: <1370446156-11788-1-git-send-email-aida.mynzhasova@skitlab.ru>
 <alpine.DEB.2.02.1306060414580.15042@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306060414580.15042@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [130605 21:22]:
> Hi,
> 
> also,
> 
> On Wed, 5 Jun 2013, Aida Mynzhasova wrote:
> 
> > Aida Mynzhasova (5):
> >   ARM: OMAP: AM33xx: multiple renames for early initialization
> 
> If this patch is what's responsible for all the file renaming, please drop 
> it.  Looks from the change summary that it's just useless churn (although 
> I haven't seen the patch here since it never made it to the lists)

Yes no reason for all the renaming, marketing names can be
whatever. For example, we have am/dm37xx too which is really
omap36xx.

Regards,

Tony
