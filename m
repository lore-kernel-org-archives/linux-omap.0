From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: User GPLv2 for MMU,
	make checkpatch.pl happier
Date: Tue, 4 Dec 2007 12:04:25 +0530
Message-ID: <5d5443650712032234u4fca1546la246bd633cb1cb50@mail.gmail.com>
References: <20071203222651.GE4105@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071203222651.GE4105@atomide.com>
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
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Dec 4, 2007 3:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Paul, Toshihiro & Hiroshi,
>
> I'm preparing the MMU patches for submission to arm-linux mailing
> list, and Paul Mundt requested changing the MMU license to be
> GPLv2. Can you please take a look at the attached patch and ack?
>

Good to see that MMU fwk going mainline, but I am concerned about the
users of MMU fwk
as of now, dspgw looks like may not be accepted to mainline yet, and
OMAP2 camera driver
is still not using the MMU fwk for it's MMU and IVA driver is no where
in sight, in this case
I don't know what purpose MMU fwk will serve in mainline code?

-- 
--Trilok Soni
