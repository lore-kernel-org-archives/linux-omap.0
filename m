From: "Amit Verma" <vermanamit@gmail.com>
Subject: Re: [H6300-port] xserver compilation giving problem :-> how to run
	X (with touch) on omap
Date: Thu, 14 Sep 2006 20:57:02 +0530
Message-ID: <5a2ffe1f0609140827mec09265i9f20ac06e5daeb49@mail.gmail.com>
References: <5a2ffe1f0609140338u5b67ce00pf909d519c5b2a624@mail.gmail.com>
	<1403915651.20060914181030@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1403915651.20060914181030@gmail.com>
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
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, h6300-port@handhelds.org
List-Id: linux-omap@vger.kernel.org

A warm hello! to you Paul

I already solved that problem (as i already posted) and i'll tell the
solution also in sometime :-)

Anyways! thanks! for the info

regards
-Amit

On 9/14/06, Paul Sokolovsky <pmiscml@gmail.com> wrote:
> Hello Amit,
>
>
>      This is not first message from you I see (via
> h6300-port@hh.org), and as I saw no replies, I will try. You may know
> or don't know, but h6300 uses OpenEmbedded (in the form of Familair
> branch fo it) to build entire userland for Linux, including
> xserver-kdrive. I don't know what you're trying to do, and what are your
> requirements, and how it's important for you to do it yourself from
> scratch, but if you'd rather reuse what's already done and works
> nice, you may be interested to have a look: http://openembedded.org .
>
>
> Thursday, September 14, 2006, 1:38:26 PM, you wrote:
>
> > Hi
>
> > I'm working on omap-1710-H3 board. I was able to flash uboot & kernel
> > successfully and now want to put X-windows on it. so...
>
> > I downloaded "xserver" from CVS (
> > anoncvs@pdx.freedesktop.org:/cvs/xserver ) as referred in the document
> > (step 1.5)  by David
> > [  NEW ver at
> > http://www.handhelds.org/hypermail/h6300-port/0/0031.html
> > OLD version at
> > http://linux.omap.com/pipermail/linux-omap-open-source/2004-November/002175.html
> > ]
>
> > when i run "./autogen.sh" it gives following error
>
> []
>
> --
> Best regards,
>  Paul                            mailto:pmiscml@gmail.com
>
>
