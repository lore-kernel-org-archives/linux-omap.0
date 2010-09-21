From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
Date: Tue, 21 Sep 2010 19:11:01 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A3478@dbde02.ent.ti.com>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
	<1285076060.14206.3.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1285076060.14206.3.camel@chotu>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Hi,

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com] 
> Sent: Tuesday, September 21, 2010 7:04 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; linux-input@vger.kernel.org; 
> Dmitry Torokhov; linux-arm-kernel@lists.infradead.org; Tony Lindgren
> Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
> 
> Hi Manjunath,
> 
> On Tue, 2010-09-21 at 13:49 +0200, ext G, Manjunath Kondaiah wrote:
> > The failure exit paths seems to be wrong in probe function.
> > This patch corrects exit failure paths for error handling cases.
> 
> https://patchwork.kernel.org/patch/160551/
> Any comments on this?

Looks fine. Sorry, I didn't look at the change. This version seems to 
be better. 

-Manjunath
