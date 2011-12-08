From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap: rx51: initialize isp1704 properly
Date: Thu, 8 Dec 2011 22:23:58 +0200
Message-ID: <CAMP44s2noD4TXBALOc0JkcbVroYFnp3BaSozrQYdUbsv50xuoQ@mail.gmail.com>
References: <20111207193141.GG31337@atomide.com>
	<1323287816-2809-1-git-send-email-felipe.contreras@gmail.com>
	<20111208144044.GA25415@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111208144044.GA25415@xps8300>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <krohei@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 8, 2011 at 4:40 PM, Heikki Krogerus <krohei@gmail.com> wrote:
> On Wed, Dec 07, 2011 at 09:56:56PM +0200, Felipe Contreras wrote:
>> From: Heikki Krogerus <krohei@gmail.com>
>
> I would prefer that you change this so this is from you, like it
> actually is. You can mention me in the commit message if you like.

Well, you came with the fix, I just typed it down, but as you wish :)

>> Without this USB networking doesn't work as the link is never detected.
>
> What this changes is, it leaves the transceiver powered by default
> instead of setting it into power off mode. So not only USB networking
> is affected by this. If isp1704_charger is not enabled with RX51, USB
> does not work at all. Please change the comment.

I've updated the patch.

Cheers.

-- 
Felipe Contreras
