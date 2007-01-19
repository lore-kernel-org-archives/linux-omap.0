From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: need help in DMA performance
Date: Thu, 18 Jan 2007 21:47:27 -0600
Message-ID: <45B03F4F.1080701@gmail.com>
References: <1c5b04b60701181235m16695fc0r7a25136d75f15afc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1c5b04b60701181235m16695fc0r7a25136d75f15afc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Bhaskara Rao Kotla <bhaskar12@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Bhaskara Rao Kotla stated on 1/18/2007 2:35 PM:
> Hi,
>    I am working on OMAPSDP 2430 platform. Can someone suggest, which
> is the
> best way to measure the real-time accurate performance of DMA
> transfer(DDR
> location A to DDR location B (or) DDR location A to SRAM location B). Is
> there any timer code APIs available to measure?
http://kerneltrap.org/node/7345
a simple ctrl+f in the include/linux gave:
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=fca93025ab5191db9a1d4aeb9734dbfa2f574a20;hb=c5783642bf20735e33f12dbe3ea1235c53cbc846;f=include/linux/hrtimer.h
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=611f17f79eefe32f78605589f175db8a77616474;hb=c5783642bf20735e33f12dbe3ea1235c53cbc846;f=include/linux/ktime.h
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=a5b739967b74f46f745526952b1c947c236cf75a;hb=c5783642bf20735e33f12dbe3ea1235c53cbc846;f=include/linux/time.h

Also i suggest a bit of google arnd.. and u;d see test code from tony
himself here:
http://muru.com/linux/omap/patches/old/patch-2.6.1-omap-dma-test.bz2 and
other patches..

Regards,
NM
