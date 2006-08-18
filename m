From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Building kenel error
Date: Fri, 18 Aug 2006 20:50:23 +0200
Message-ID: <44E60BEF.2090507@gmail.com>
References: <EA12F909C0431D458B9D18A176BEE4A5072DA5F6@dlee02.ent.ti.com>
	<1155918292.2949.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1155918292.2949.25.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: hkh@cypress.com
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hingkwan Huen wrote:
> Which version of tool chain are
> you using for 2.6.16 or 2.6.17 kernel?

Regarding GCC 4.x.x, if you like prebuild toolchain, try 
CodeSourcery:

http://www.codesourcery.com/gnu_toolchains/arm/

If you like to build your toolchain on our own, try crosstool:

http://kegel.com/crosstool/

crosstool-0.42 with

eval `cat arm.dat gcc-4.1.0-glibc-2.3.2.dat`  sh all.sh --notest

configuration and additional patch (for ALSA sound)

http://gcc.gnu.org/viewcvs/branches/csl/sourcerygxx-4_1/gcc/cse.c?r1=115616&r2=115615&view=patch&pathrev=115616
(fixes http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27363)

works for me.

There may be several other working GCC 4.x.x toolchains out 
there. But I think most people still use GCC 3.x.x toolchains.

Dirk
