From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Subject: Re: Missing "bin" file when files extracted from gcc-3.4.0.tar.bz2
Date: Fri, 20 Oct 2006 08:45:27 +0200
Message-ID: <200610200845.28619.openembedded@hrw.one.pl>
References: <20061019213008.53834.qmail@web50102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061019213008.53834.qmail@web50102.mail.yahoo.com>
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

Dnia czwartek, 19 pa=BCdziernika 2006 23:30, Rene Holder napisa=B3:

>   The project I am currently undertaking is "Building Linux for the
> OMAP5912 OSK Development Platform".=20

> One of the first steps required me to unzip the gcc-3.4.0.tar.bz2 file
> using the command: tar -xjvf /root/gcc-3.4.0.tar.bz2
>
>   One of the following instructions asked me to add the tool chain path
> to the current path via the following command: export
> PATH=3D/opt/gcc-3.4.0/bin:$PATH
>
>   Unfortunately, I am unable to locate the "bin" folder and this is
> leading to errors later on in the process. I also tried a later version
> of the gnu toolchain: gcc-3.4.3.tar.bz2 but I was still unable to
> locate the "bin" folder.
>
>   Could you please help me with this problem?

I suggest taking a look at OpenEmbedded [1] project which can build=20
working images for omap5912osk with gcc 3.4.4 or 4.1.1.

With simple configuration you can get everything needed (glibc- or uclibc-=
=20
based toolchain, 2.6.18-omap-git kernel, userspace apps) built with just=20
one command.=20

I can provide rootfs + kernel for test if someone want to take a look.


1. http://www.openembedded.org/

=2D-=20
JID: hrw-jabber.org
OpenEmbedded developer/consultant
