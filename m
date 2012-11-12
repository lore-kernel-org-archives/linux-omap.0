From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Mon, 12 Nov 2012 12:03:23 +0100
Message-ID: <11727BE5-7173-4383-BD0E-751EFD093706@dominion.thruhere.net>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Op 5 nov. 2012, om 21:40 heeft Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> het volgende geschreven:

> Hey folks,
> 
> As promised, here is my early draft to try and capture what device
> tree overlays need to do and how to get there. Comments and
> suggestions greatly appreciated.
> 
> Device Tree Overlay Feature
> 
> Purpose
> =======
> Sometimes it is not convenient to describe an entire system with a
> single FDT. For example, processor modules that are plugged into one or
> more modules (a la the BeagleBone), or systems with an FPGA peripheral
> that is programmed after the system is booted.
> 
> For these cases it is proposed to implement an overlay feature for the
> so that the initial device tree data can be modified by userspace at
> runtime by loading additional overlay FDTs that amend the original data.
> 
> User Stories
> ============
> Note - These are potential use cases, but just because it is listed here
> doesn't mean it is important. I just want to thoroughly think through the
> implications before making design decisions.

I think the beaglebone use cases cover it as well, but it deserves a seperate mention: SOMs. Gumstix is a good example of those, their website has a list of the different expansionboards they sell so we can see if we missed a use case somewhere.
Their expansionboards have an EEPROM to ID them, just like the beagleboard classic/xM expansionboards, but I don't know if all 3rd party vendors honour that standard. I know the Ettus USRP E-100 on my desk has it.

regards,

Koen
