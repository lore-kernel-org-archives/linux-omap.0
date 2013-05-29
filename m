From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH v2] usb: musb: fix clock naming
Date: Wed, 29 May 2013 11:36:04 +0200
Message-ID: <1369820164.6673.55.camel@polaris.local>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
 <20130528173637.GE15794@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130528173637.GE15794@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: yegorslists@googlemail.com, tony@atomide.com, linux-usb@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-05-28 at 20:36 +0300, Felipe Balbi wrote: 
> On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists@googlemail.com wrote:
> > From: Yegor Yefremov <yegorslists@googlemail.com>
> > 
> > 'ick' was changed to 'hsotgusb_ick'
> > 'fck' was changed to 'hsotgusb_fck'
> > 
> > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> NAK. Fix your clock data.

Yegor, I'm not sure how my signed-off-by got here. It seems that you
picked the patch up from this thread:
http://marc.info/?l=linux-omap&m=134390141101734

Note that my mail contains no signed-off-by and the change is described
as a work around.

Regards,
Jan
