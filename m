From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Mon, 7 Jan 2013 22:26:31 +0200
Message-ID: <FA4D880E-833E-43D9-A399-0A5C260E83F2@antoniou-consulting.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <1357584666-17374-2-git-send-email-panto@antoniou-consulting.com>
 <20130107200945.GF14149@atomide.com>
 <379B16EC-BFAA-4C27-8321-E7133C03368D@antoniou-consulting.com>
 <20130107202306.GH14149@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130107202306.GH14149-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Jan 7, 2013, at 10:23 PM, Tony Lindgren wrote:

> * Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> [130107 12:16]:
>> Hi Tony,
>> 
>> On Jan 7, 2013, at 10:09 PM, Tony Lindgren wrote:
>> 
>>> * Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> [130107 10:54]:
>>>> A cape loader based on DT overlays and DT objects.
>>>> 
>>>> Beaglebone cape manager implementation.
>>>> 
>>>> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>>>> ---
>>>> arch/arm/mach-omap2/Kconfig            |    2 +
>>>> drivers/misc/Kconfig                   |    2 +
>>>> drivers/misc/Makefile                  |    1 +
>>>> drivers/misc/cape/Kconfig              |    5 +
>>>> drivers/misc/cape/Makefile             |    5 +
>>>> drivers/misc/cape/beaglebone/Kconfig   |   11 +
>>>> drivers/misc/cape/beaglebone/Makefile  |    5 +
>>>> drivers/misc/cape/beaglebone/capemgr.c | 1835 ++++++++++++++++++++++++++++++++
>>> 
>>> The driver should probably be in drivers/bus?
>>> 
>> 
>> It was a bus on the previous iteration and there was a flame storm of epic proportions.
> 
> Heh :)
> 
>> It is not a bus at all now, it's just a device loader; there are no
>> bus constructs at all. I am at a loss to classify it really, so drivers/misc
>> where every misfit ends up sounded OK.
> 
> Right..
> 
>> I'm open to suggestions though.
> 
> Well how about split it to an eeprom driver, and Linux generic
> device loader parts?
> 

All that's left is the eeprom driver (accessor) and calls to the 
generic DT overlay constructs. 

If you caught on the previous patchset about DT overlays it should be
clear.

So it is split along those lines already.


> Regards,
> 
> Tony

Regards

-- Pantelis
