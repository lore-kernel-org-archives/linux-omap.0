From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCHv6] support for AD5820 camera auto-focus coil
Date: Wed, 10 Aug 2016 15:00:32 +0300
Message-ID: <20160810120032.GO3182@valkosipuli.retiisi.org.uk>
References: <573FFF51.1000004@gmail.com> <20160521105607.GA20071@amd>
 <574049EF.2090208@gmail.com> <20160524090433.GA1277@amd>
 <20160524091746.GA14536@amd>
 <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd> <20160805102611.GA13116@amd>
 <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
 <20160810073403.GB30047@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160810073403.GB30047@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-media@vger.kernel.org, khilman@kernel.org, tony@atomide.com, mchehab@osg.samsung.com, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 10, 2016 at 09:34:03AM +0200, Pali Roh=E1r wrote:
> On Monday 08 August 2016 11:09:56 Sakari Ailus wrote:
> > On Fri, Aug 05, 2016 at 12:26:11PM +0200, Pavel Machek wrote:
> > > =

> > > This adds support for AD5820 autofocus coil, found for example in
> > > Nokia N900 smartphone.
> > =

> > Thanks, Pavel!
> > =

> > Let's use V4L2_CID_FOCUS_ABSOLUTE, as is in the patch. If we get someth=
ing
> > better in the future, we'll switch to that then.
> =

> Ok, and what with AD5820_RAMP_TIME and AD5820_RAMP_MODE?
> =

> > I've applied this to ad5820 branch in my tree.
> =

> Are you going to finally send this patch to media tree or pull request
> to Linus?

That'll be through media-tree.

-- =

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
