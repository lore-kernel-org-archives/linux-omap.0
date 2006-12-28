From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: ISP1301 workqueue fixes
Date: Thu, 28 Dec 2006 12:07:04 -0800
Message-ID: <200612281207.04428.david-b@pacbell.net>
References: <45937A00.1070803@gmail.com>
	<3a5b1be00612280430u5117383eme98f2d1ce50c411f@mail.gmail.com>
	<4593EE99.9080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4593EE99.9080108@gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 28 December 2006 8:19 am, Dirk Behme wrote:
> Komal Shah wrote:
> > On 12/28/06, Dirk Behme <dirk.behme@googlemail.com> wrote:
> ...
> >> Index: linux-osk/drivers/i2c/chips/isp1301_omap.c
> >> ===================================================================
> >> --- linux-osk.orig/drivers/i2c/chips/isp1301_omap.c
> >> +++ linux-osk/drivers/i2c/chips/isp1301_omap.c
> >> @@ -1119,9 +1119,9 @@ static u8 isp1301_clear_latch(struct isp
> >>  }
> >>
> >>  static void
> >> -isp1301_work(void *data)
> >> +isp1301_work(struct work_struct *data)
> >>  {
> >> -       struct isp1301  *isp = data;
> >> +       struct isp1301  *isp = (struct isp1301 *)data;
> > 
> > 
> > Why not use container_of ? Did you tested it?
> 
> Can anybody with H2/H3 board test this? 

Not worth testing, it's clearly incorrect.
