From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] OMAPDSS: OMAPFB: fix framebuffer console colors
Date: Mon, 06 Aug 2012 15:26:57 +0300
Message-ID: <501FB811.1070101@compulab.co.il>
References: <1344097153-13903-1-git-send-email-notasas@gmail.com>  <1344232816.6227.0.camel@lappyti> <501F9946.3030504@compulab.co.il> <1344252160.12136.13.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:53234 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341Ab2HFM1E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Aug 2012 08:27:04 -0400
In-Reply-To: <1344252160.12136.13.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 08/06/12 14:22, Tomi Valkeinen wrote:
> On Mon, 2012-08-06 at 13:15 +0300, Igor Grinberg wrote:
>> On 08/06/12 09:00, Tomi Valkeinen wrote:
>>> On Sat, 2012-08-04 at 19:19 +0300, Grazvydas Ignotas wrote:
>>>> omapfb does not currently set pseudo palette correctly for color depths
>>>> above 16bpp, making red text invisible, command like
>>>>   echo -e '\e[0;31mRED' > /dev/tty1
>>>> will display nothing on framebuffer console in 24bpp mode.
>>>> This is because temporary variable is declared incorrectly, fix it.
>>>
>>> Thanks, applied to OMAP DSS tree.
>>
>> Is it also applicable to stable?
>> If yes, Tomi, can you please add the Cc tag?
> 
> Yes, the bug has been there from the beginning.
> 
> I can add the Cc tag. But I wonder is it enough just to have the tag, or
> should I also send the patch forward? And does it only get applied to
> the latest stable tree, not the earlier ones?

Well, the Documentation/stable_kernel_rules.txt says:

 - To have the patch automatically included in the stable tree, add the tag
     Cc: stable@vger.kernel.org
   in the sign-off area. Once the patch is merged it will be applied to
   the stable tree without anything else needing to be done by the author
   or subsystem maintainer.
 
So I guess, you don't need to resend it.

Also, IIUC, if you can identify all the stable kernels it applies to,
you can specify them like:
Cc: <stable@vger.kernel.org> # 3.x, 2.6.x
This can save some work for those responsible for adding the patch to stable.
Now, if you say, it is applicable to all kernels since the omapfb support was
merged, I think, the above example it the right choice.

Anyway, Greg, please correct me if I've got anything wrong.

Thanks

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQH7gRAAoJEBDE8YO64EfakCAP/izNPA/HcFhxE3cRJJhlh5xw
Caf4h6gXjdTNekSfLEppyo+uf6F2ef8ojZFoim1x59phjC9N9TQWyqTgV6qTGWul
o8YtCo3CMXPTVnxgoYtIFNDIngiuZFVATEWdoHlxlpWwBXWcr6K101Rg+x0hlvzl
CAqquuwjO+GFmPn+6hLns3sFJcnD02e2Rb0tX29Yg/SdFCMPDIRA3NUANVqILcxN
do6mWpZ3tKOmPzobUDr1tswJxK94oc0pIjKMjxy71qAxpLMtY2bVNKavKuGsgaRr
Nl7Bml5e1vCvAJNtYTpiMKvjomTvS1gktBoAa43u81THDrvwzJNO/mUq88CuMOg0
D0k8ohKrv0/WyKr+LZe9W4l4I9lIvbutvF5oxcU+1gC01pMlr9qghO8J3Oz5/UTi
/Swd7Q5I6X29TtudIuAsZ8g5didNBTLYgih+DODviTRzaca7msF+VfNkcg2IeOuA
MvkMwiZSZX15ggriH07dEr+Z2XF7mMYVMgn492RokMzeXx31VXeHYv9pNGXcF+xn
xV55Z03RT2jcnIPJVSfnzXAXIhTdkM2MVBaS/iNKckPW1Q1quiY/7IeWJaX59LBl
bWUIFC02HJ+n8S2Tyqbr+7+0ue6v3xVocw/fcwx0PCLx0HltxhrAJJzTB+o4SDya
DpSx1+W2seaVbd7AgkmN
=qbs/
-----END PGP SIGNATURE-----
