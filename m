From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] PalmZ71 - palmz71 specific
Date: Wed, 25 Oct 2006 21:03:35 +0300
Message-ID: <20061025180333.GH4852@atomide.com>
References: <200610241724.50323.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610241724.50323.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061024 18:27]:
> Hi,
> this is the rest of the code - palmz71 specific things - board file, lc=
d etc.

Thanks for splitting the patches. Can you please split this patch one
more time to separate the video stuff into a separate patch?

The reason being that the arch/arm/*omap*/* and include/asm-arm/arch-omap=
/*
patches go to the mainline pretty much as they are. (And omap video is
not yet in the mainline)

Please also reply with your Signed-off-by: line to your other patches.

Regards,

Tony
