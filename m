From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: v4.15: camera problems on n900
Date: Fri, 29 Dec 2017 11:38:55 +0200
Message-ID: <20171229093855.hz44vpssb5mufzop@valkosipuli.retiisi.org.uk>
References: <20171227210543.GA19719@amd>
 <20171227211718.favif66afztygfje@kekkonen.localdomain>
 <20171228202453.GA20142@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171228202453.GA20142@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, linux-media@vger.kernel.org, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, laurent.pinchart@ideasonboard.com, Sakari Ailus <sakari.ailus@linux.intel.com>, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 28, 2017 at 09:24:53PM +0100, Pavel Machek wrote:
> On Wed 2017-12-27 23:17:19, Sakari Ailus wrote:
> > On Wed, Dec 27, 2017 at 10:05:43PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > In v4.14, back camera on N900 works. On v4.15-rc1.. it works for few
> > > seconds, but then I get repeated oopses.
> > > 
> > > On v4.15-rc0.5 (commit ed30b147e1f6e396e70a52dbb6c7d66befedd786),
> > > camera does not start.	  
> > > 
> > > Any ideas what might be wrong there?
> > 
> > What kind of oopses do you get?
> 
> Hmm. bisect pointed to commit that can't be responsible.... Ideas
> welcome.

Hi Pavel,

I tested N9 and capture appears to be working from the CSI-2 receiver
(media tree master, i.e. v4.15-rc3 now).

Which pipeline did you use?

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
