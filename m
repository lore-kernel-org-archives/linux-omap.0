From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/11] Add VFP support for ARM V7 - OMAP 3430 support
Date: Wed, 30 May 2007 10:51:46 +0530
Message-ID: <5d5443650705292221s6aa8ba60t5442e0ca2b6fff8e@mail.gmail.com>
References: <5d5443650705282359l36210f66m7862c01d04fccf@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C47FF10A1@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF10A1@dlee13.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 5/29/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Hi Trilok,
>
> >>
> >> Could you please check that ARMv7 and VFPv3 code is latest and same as
> >> available on http://www.linux-arm.og/git ?
> >
> >Typo. correct link http://www.linux-arm.org/git
> >
>
> This patch was generated based on 2.6.19 patch from ARM's site. I haven't looked at the latest ARM GIT for changes.
>
> My current approach is to get a basic booting environment for 3430 on OMAP GIT and then work on ARM Cortex patches. I will definitely refer to the latest ones then.
>
> The other major issue is getting Cortex support on OMAP GIT. I think it makes more sense to get them sooner on ARM tree instead of OMAP GIT.
>
> We have to work with ARM and RMK to identify the issues and speed up this process. >Don't know how far we will be able to succeed in that.

Yes, this could be slow. In this case, I suggest to cherrypick ARMv7
core related patches from linux-arm.org/git tree and add it to OMAP
GIT and on top of that you can apply any ARMv7 core changes required
in order to boot 3430. This will help us to keep git history in good
shape.

-- 
--Trilok Soni
