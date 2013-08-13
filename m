From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] staging: Platform device tester - Allow removal
Date: Tue, 13 Aug 2013 22:04:36 +0300
Message-ID: <B2F211B9-E02D-4B02-8813-2DCE511CE48C@antoniou-consulting.com>
References: <1376386470-27328-1-git-send-email-panto@antoniou-consulting.com> <20130813182012.GE7740@kroah.com> <70F17005-652E-4C04-B6EC-51E16EE237C3@antoniou-consulting.com> <20130813185521.GA9483@kroah.com> <DB915540-70CB-4600-BF8D-734107B1FE29@antoniou-consulting.com> <20130813190233.GB25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130813190233.GB25647@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt_Coussno?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sourav Poddar <sourav.poddar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Felipe Balbi <balbi@ti.com>, Koen Kooi <koen@circuitco.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Aug 13, 2013, at 10:02 PM, Russell King - ARM Linux wrote:

> On Tue, Aug 13, 2013 at 09:59:03PM +0300, Pantelis Antoniou wrote:
>> Hi Greg,
>> 
>> Just to make sure we're on the same page this is with my platform device
>> removal patchset applied.
>> 
>> Without it you get the original crash I've posted in the pdevtest patch with
>> the unbind method.
> 
> Yes, congratulations, you've found a bug in the way OMAP uses the runtime
> PM stuff in this driver.  That bug needs to be fixed irrespective of
> anything else.

Not just OMAP. And not just PM stuff. 
There are crashes occurring due to the way resources are handled by
platform devices created via OF.

Regards

-- Pantelis
