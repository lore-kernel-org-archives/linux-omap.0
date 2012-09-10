From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: Re: [PATCH 1/2] gpio/twl4030: get platform data from device tree
Date: Mon, 10 Sep 2012 10:40:06 +0200
Message-ID: <504DA766.1080304@epfl.ch>
References: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch>
 <1346831186-29947-2-git-send-email-florian.vaussard@epfl.ch>
 <504A2FF2.7070607@ti.com> <504DA20D.7020903@epfl.ch>
 <504DA503.5050901@ti.com>
Reply-To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <504DA503.5050901-l0cyMroinI0@public.gmane.org>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello Benoit,

>>
>> I fixed them since it was trivial, but next time you should ensure
>> that the patch pass checkpatch before posting.
>> Sorry for these errors. I however checked my patches before submitting,
>> and had no such warnings. I redone, and remarked that these warnings
>> appear only with the "--strict" option, which is not enabled by default.
>> Is this the recommended  guideline? Thus why not enabling it by default?
> That's a pretty good question :-)
>
> Maybe the --strict is more a nice to have than a strong requirement?
> Anyway, we'd better run checkpatch with --strict and thus fix any
> cosmetic details that might be in the patch.

Good to know, I will use --strict for the next submissions.

> Cool, I love chocolate. That being said, I'm not sure how tasteful 
> will be the *virtual* chocolate. Regards, Benoit 

Even *virtual*, Swiss chocolate will be the most tasteful (hope no Belgium
friends will see this thread) :-)

Regards,
Florian
