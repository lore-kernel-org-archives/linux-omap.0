From: Kevin Hilman <khilman@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Thu, 25 Aug 2011 11:16:25 -0700
Message-ID: <877h6173wm.fsf@ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110824231613.GC19890@legolas.emea.dhcp.ti.com>
	<20110825102824.GB10405@n2100.arm.linux.org.uk>
	<201108251705.43168.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Cousson,
	Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: linux-omap@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 25 August 2011, Russell King - ARM Linux wrote:
>> 
>> On Thu, Aug 25, 2011 at 02:16:14AM +0300, Felipe Balbi wrote:
>> > on top of all that, for IPs which are used on many SoCs (such as MUSB)
>> > it's quite silly to force all users to provide resources in a certain
>> > order. It sounds to me that this will be prone to error in many ways
>> > until everything is synced up and on the correct order.
>> > 
>> > Ditching _byname is a very bad idea.
>> 
>> I continue to disagree.  The current _byname is an abonimation and hack
>> to try to "fix" this problem.
>> 
>> _byname should have been implemented differently - rather than overriding
>> the resources name field (which is normally specified to be the device
>> or driver name), a new field should have been introduced in struct resource
>> to carry the resource sub-name (which is really what it is.)
>> 
>> That would have avoided making /proc/iomem completely illegible with
>> multiple devices using this feature.
>
> I agree 100%.

Please clarify. 

What I hear Russell saying is a problem with the *implementation* of the
_byname API.  

What I hear you sating is that since DT doesn't support this, we need to
remove it's usage completely from platform_devices also.

These are two very different approaches.

Fixing the implementation as Russell suggested seems relatively easy,
and conceptually similar to adding it to the DT.  Removing _byname all
together seems like significant work just to avoid adding a feature to
the DT core.

Kevin
