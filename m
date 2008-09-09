From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: Working with Linux-Omap GIT Tree
Date: Tue, 9 Sep 2008 14:52:27 -0400
Message-ID: <1f11a5490809091152j767d9032jecdeeace5b2d40bb@mail.gmail.com>
References: <1f11a5490809041150y69023b30ub166cc34615744b5@mail.gmail.com>
	 <A24693684029E5489D1D202277BE894411A86A45@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:61989 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbYIISw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 14:52:29 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1203249yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 09 Sep 2008 11:52:28 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE894411A86A45@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

A quick question about the OMAP GIT trees as I'm playing with them
right now. There are two trees that I can see, one at
http://git.omapzoom.org/repo/omapkernel and another at
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git.
The OMAPZoom tree seems to have a few of the files that are missing
from the git.kernel.org tree that I was looking to modify..

Which tree should I be using to put my board-support files into? Or is
it a combination of the two?

Regards

On Thu, Sep 4, 2008 at 3:04 PM, Aguirre Rodriguez, Sergio Alberto
<saaguirre@ti.com> wrote:
> And one more thing...
>
> If you have a driver which was previously including a header like this:
>
> #include <arch/arm/clock.h>
>
> You have to change it to:
>
> #include <mach/clock.h>
>
> To point to the new location.
>
> Regards,
> Sergio
>
> -----Original Message-----
> From: Ashwin Bihari [mailto:abihari@gmail.com]
> Sent: Thursday, September 04, 2008 1:51 PM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Working with Linux-Omap GIT Tree
>
> On Thu, Sep 4, 2008 at 2:44 PM, Aguirre Rodriguez, Sergio Alberto
> <saaguirre@ti.com> wrote:
>> Hi Ashwin,
>>
>> The folder you're looking for has been moved to arch/arm/plat-omap/include/
>>
>> This has to have the same contents you had in that version + the following changes to them.
>>
>> Hope this helped you.
>>
>> Regards,
>> Sergio
>
> Hi Sergio,
>
> Thanks for the pointer on the move. I should've spent more time poking
> around the trees I guess. Sorry for the noise..
>
> ~ Ashwin
>
>
