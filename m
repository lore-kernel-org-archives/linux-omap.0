From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: Re: Looking for gcc-3.4.0
Date: Tue, 23 Jan 2007 06:21:45 +0100
Message-ID: <200701230621.45333.marek.vasut@gmail.com>
References: <200701230226.l0N2QOPW016558@dislab.nju.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200701230226.l0N2QOPW016558@dislab.nju.edu.cn>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dne =FAter=FD 23 leden 2007 04:15 zhangshigeng napsal(a):
> Hi:
>
>          We're now trying to port linux-2.6 to our omap5912 board. But now
> we cannot find a gcc-3.4.0 based cross-complier to compile the kernel.
>
> Somebody mentioned that there is a appropriate version on the CodeSourcery
> site. But there are several different versions on the site, can somebody
>
> tell me which one is gcc-3.4.0 based?
>
>          Thanks.
>
>          ZHANG Shi-Geng
>

you can use scratchbox (scratchbox.org) and whatever toolchain you want ...=
 I=20
think uclibc-arm are best, it doesnt matter what version of gcc you have=20
(should be at least >3.4 though). gcc4 is fine too.
