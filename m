From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Git tree updated to 2.6.23-rc2
Date: Mon, 6 Aug 2007 18:56:01 +0530
Message-ID: <5d5443650708060626j18300bedxf3dea1cd324ba2cc@mail.gmail.com>
References: <20070806125225.GA2312@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070806125225.GA2312@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 8/6/07, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> I've just updated our git tree to 2.6.23-rc2. Thanks to Trilok, now
> the omap framebuffer code is integrated to the mainline kernel :)
>
> There are quite a few pending patches, I will be looking at them
> this week.

Currently mainline kernel for omap2 is broken if you enable menelaus,
as pdata structure from menelaus.h is not submitted, and omap mmc also
fails to build.

Also H4 doesn't boot, as L4 entry is missing from io.c in mainline kernel.

-- 
--Trilok Soni
