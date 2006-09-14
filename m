From: "Amit Verma" <vermanamit@gmail.com>
Subject: Re: xserver compilation giving problem :-> how to run X (with
	touch) on omap
Date: Thu, 14 Sep 2006 18:32:00 +0530
Message-ID: <5a2ffe1f0609140602j4faf231rff3614b313074a90@mail.gmail.com>
References: <5a2ffe1f0609140338u5b67ce00pf909d519c5b2a624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5a2ffe1f0609140338u5b67ce00pf909d519c5b2a624@mail.gmail.com>
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
To: david.cohen@indt.org.br
Cc: linux-omap-open-source@linux.omap.com, h6300-port@handhelds.org
List-Id: linux-omap@vger.kernel.org

Guys!

I solved it myself :-)

thanks! anyways
-Amit Verma


On 9/14/06, Amit Verma <vermanamit@gmail.com> wrote:
> Hi
>
> I'm working on omap-1710-H3 board. I was able to flash uboot & kernel
> successfully and now want to put X-windows on it. so...
>
> I downloaded "xserver" from CVS (
> anoncvs@pdx.freedesktop.org:/cvs/xserver ) as referred in the document
> (step 1.5)  by David
> [  NEW ver at http://www.handhelds.org/hypermail/h6300-port/0/0031.html
> OLD version at http://linux.omap.com/pipermail/linux-omap-open-source/2004-November/002175.html
> ]
>
> when i run "./autogen.sh" it gives following error
>
> "
> checking for randrproto renderproto fixesproto damageproto xextproto
> xfont xproto xtrans xau compositeproto resourceproto recordproto xdmcp
> xdmcp... Package randrproto was not found in the pkg-configsearch
> path.
> Perhaps you should add the directory containing `randrproto.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'randrproto' found
>
> configure: error: Library requirements (randrproto renderproto
> fixesproto damageproto xextproto xfont xproto xtrans xau
> compositeproto resourceproto recordproto xdmcp xdmcp) not met;
> consider adjusting the PKG_CONFIG_PATH environment variable if your
> libraries are in a nonstandard prefix so pkg-config can find them.
> "
>
> I guess the problem is the absence of   " *proto.pc " files in the
> PATH, but anyways i could fine them also in the system. So from where
> i can get them or is it some other problem which is causing this
> error.
>
> I'm successfully done upto 1.4 steps.
>
> Plz help.
>
> thanks! in advance
> -Amit Verma
>
