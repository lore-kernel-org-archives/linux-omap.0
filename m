From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/9] PM: Create the AVS class of drivers
Date: Wed, 18 Apr 2012 20:49:53 +0200
Message-ID: <201204182049.53212.rjw@sisk.pl>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <878vhski53.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <878vhski53.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, jean.pihet@newoldbits.com, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday, April 18, 2012, Kevin Hilman wrote:
> Rafael,
> 
> jean.pihet@newoldbits.com writes:
> 
> > From: Jean Pihet <j-pihet@ti.com>
> >
> > AVS is a power management technique which controls the operating
> > voltage of a device in order to optimize (i.e. reduce) its power
> > consumption. The voltage is adapted depending on static factors
> > (chip manufacturing process) and dynamic factors (temperature
> > depending performance).
> > AVS is also called SmartReflex on OMAP devices.
> >
> > To that end, create the AVS framework in drivers/power/avs and
> > move the OMAP SmartReflex code to the new directory.
> 
> I've done a review of this series and had a few very minor comments.
> 
> Once those are addressed, are you OK with us moving this AVS driver
> under drivers/power?

Yes, I am.

Thanks,
Rafael
