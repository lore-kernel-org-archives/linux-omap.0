From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Fri, 17 Aug 2007 09:57:44 -0700
Message-ID: <200708170957.44311.david-b@pacbell.net>
References: <46C5C233.5090405@googlemail.com>
	<31e679430708170912p1bd8050dg38db45d14d237961@mail.gmail.com>
	<46C5CF29.2020601@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46C5CF29.2020601@googlemail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>, Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> this doesn't look right since any device can issue SRP. It's better
> for you to use it somewhere on DaVinci.

That "issue SRP" attribute has no business being specific to any
particular platform.
