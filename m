From: "Ola Helm" <ola.hel@gmail.com>
Subject: Re: v4l2 camera test app
Date: Mon, 20 Mar 2006 15:19:37 +0200
Message-ID: <3d3153f60603200519t2173ce20l52d184b0a6a39ff@mail.gmail.com>
References: <20060316102515.10010.qmail@web32907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060316102515.10010.qmail@web32907.mail.mud.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Have you got some idea what's the situation of the 24xx camera driver at th=
e
moment? AFAIK the patch David sent in last month is not included to tree,
propably since there were some opposite opinions about the way of
implementation and at least I did not have one file mentioned in patch (I
think you mentioned about the same issue)

/O

On 3/16/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
>
> Hi All,
>
> As I had received 2-3 emails in the past for simple v4l2 camera capture
> test application for OMAP, I have attached the one which I have tested
> with OMAP2420 TI EVM.
>
> To compile
> #arm-linux-gcc -o vcaputre vcam.c
>
> To execute
> #./vcaputre -n 20 -m -C cam.dump
>
> Enjoy and fix the bugs you find yourself or send me the patch. There
> are quite lot of improvments one can do to this app :)
>
> ---Komal Shah
> http://komalshah.blogspot.com/
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
>
