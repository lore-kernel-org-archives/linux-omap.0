From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Sat, 16 Aug 2008 12:57:47 +0300
Message-ID: <94a0d4530808160257r77341fafn5f2b8404a8510203@mail.gmail.com>
References: <94a0d4530808151409p309cf9e2sf1ab3274baac32fb@mail.gmail.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434E08@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:3786 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbYHPJ5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Aug 2008 05:57:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1310761rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 16 Aug 2008 02:57:47 -0700 (PDT)
In-Reply-To: <EBA93F3E4CB46947A4C5275F6308CF3E03434E08@dlee15.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pasam, Vijay" <vpasam@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, soni.trilok@gmail.com, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, felipe.contreras@nokia.com

Hi Vijay,

On Sat, Aug 16, 2008 at 12:59 AM, Pasam, Vijay <vpasam@ti.com> wrote:
>> I'm not familiar with checkpatch, but I guess the purpose is
>> not to highlight functional issues.
>>
>> However, there are functional issues, but it makes sense to
>> cleanup the code first: there's no point in analyzing code
>> that is never used.
>
> There are about 9 errors with the latest set of patches. These are all
> false positives - not really errors. Majority of warnings also fall
> under this category.

I'm not talking about issues returned by checkpatch, but issues
visible to the human observer.

>> I'm not familiar with checkpatch, but I guess the purpose is
>> not to highlight functional issues.
>> Indeed, if I put myself the open source cap I can create ARM
>> side applications, but then I need something running on the
>> DSP in order to test them. If I put my corporate cap I can do
>> that, and see that effectively, my ARM application works. But
>> how are maintainers supposed to test this?
>>
>> At the very least I would expect a base image binary, and a
>> dummy dsp node that simply copies the buffers received so
>> that anyone can get their hands dirty with the dsp bridge.
>> Otherwise it's just some code that nobody can test (hard to
>> merge that way).
>
>
> There are some sample applications distributed to test bridge
> functionality. There are DSP side binaries provided along with ARM side
> application that can be used to test the changes done on Bridge. You can
> download sample applications at
> http://omapzoom.org/gf/project/omapbridge/wiki/?pagename=Software+Inform
> ation

It's not possible to build the nodes in 'dspbridge_samples.tar.gz'. It
seems the 'ti.bios' package is missing. Apparently the 'ti.rtdx'
package is missing too, but I don't think it's really required for
simple nodes.

The source for 'cexec' and 'dynreg' is present, so that's good.

Still, there's no base image binary. So now way of testing the nodes anyway.

Best regards.

-- 
Felipe Contreras
