From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] OMAPDSS: OMAPFB: fix framebuffer console colors
Date: Mon, 06 Aug 2012 13:15:34 +0300
Message-ID: <501F9946.3030504@compulab.co.il>
References: <1344097153-13903-1-git-send-email-notasas@gmail.com> <1344232816.6227.0.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:42629 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785Ab2HFKPl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Aug 2012 06:15:41 -0400
In-Reply-To: <1344232816.6227.0.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/06/12 09:00, Tomi Valkeinen wrote:
> On Sat, 2012-08-04 at 19:19 +0300, Grazvydas Ignotas wrote:
>> omapfb does not currently set pseudo palette correctly for color depths
>> above 16bpp, making red text invisible, command like
>>   echo -e '\e[0;31mRED' > /dev/tty1
>> will display nothing on framebuffer console in 24bpp mode.
>> This is because temporary variable is declared incorrectly, fix it.
> 
> Thanks, applied to OMAP DSS tree.

Is it also applicable to stable?
If yes, Tomi, can you please add the Cc tag?

Thanks

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQH5lGAAoJEBDE8YO64Efak/YP/3APyqQ3d4TLB8sG7oHSF/Vn
zmwMl8kH2B70WIPWU1iIExodfrDd3Gms8UeGqjhj04kLHvqYUs3/lepTA6gkEnH0
U4vyO6WTMYtWBHUGXJhZk5GpOByn4aLdk4UGV22NNMmUI/xWqcVGSnntLjmRcUyu
Y1JRQqhlrXrYXH5A866J7yrwSwhhZ/sZXs4k1N5keCNaT8ieqn0HXvu02ma7bjF7
SvhWDPNOOWUuEOGsope8F2A8Mot4ToManqRHDTUSnq/cpWziGiy6/7I7ngVIMUgD
/nmiLISgU72wkoNDl0AxGQDVQ8HFUspzGe2e12VliG+ErmFkGfKr9XdI6fx7gKh2
ks7qL+uMBau9MpWYcRPhPvYrVn7tg6V9seN2/bG5gp2IgMFbu1wmibVMNyCGhQeX
1OhshGEKeR58s+R8KZ7+UzbjspDuSnlnFH2wVbbb3wr30Swc6VZA/rWlwNg3Bgz5
/h63a5SOwTF9nmV+3/O/ky4gyMORbbJyOBK/xWVmQkZ4lNNW02RnMaa6KP8fKlbb
Cc7x1P07jcMH83LKGyyhsvZrK/4JCloYEDTvuYHprf9Wb+WsXNCLsRiYMngUIwPc
eLrBVOlELQvS237eGAwMIfo4Lm3tI3WMyr8cjGy2aRqn8voDJW+qEN2NUNwkNDqS
kGYrOE0t5VRNx5egrv+J
=kydA
-----END PGP SIGNATURE-----
