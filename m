From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] Broken DM816x support in Linux 3.10-rc4
Date: Thu, 6 Jun 2013 04:16:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306060414580.15042@utopia.booyaka.com>
References: <1370446156-11788-1-git-send-email-aida.mynzhasova@skitlab.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370446156-11788-1-git-send-email-aida.mynzhasova@skitlab.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

also,

On Wed, 5 Jun 2013, Aida Mynzhasova wrote:

> Aida Mynzhasova (5):
>   ARM: OMAP: AM33xx: multiple renames for early initialization

If this patch is what's responsible for all the file renaming, please drop 
it.  Looks from the change summary that it's just useless churn (although 
I haven't seen the patch here since it never made it to the lists)


- Paul
