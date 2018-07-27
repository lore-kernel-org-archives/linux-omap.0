From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH, libv4l]: Make libv4l2 usable on devices with complex
 pipeline
Date: Fri, 27 Jul 2018 09:47:08 -0300
Message-ID: <20180727094708.18ef4e4e@coco.lan>
References: <20180708213258.GA18217@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180708213258.GA18217@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mchehab@s-opensource.com, ivo.g.dimitrov.75@gmail.com, linux-media@vger.kernel.org, khilman@kernel.org, tony@atomide.com, hans.verkuil@cisco.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?UTF-8?B?TWF0aWpldmnEhw==?= <filip.matijevic.pz@gmail.com>, sakari.ailus@iki.fi, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Em Sun, 8 Jul 2018 23:32:58 +0200
Pavel Machek <pavel@ucw.cz> escreveu:

> Add support for opening multiple devices in v4l2_open(), and for
> mapping controls between devices.
> 
> This is necessary for complex devices, such as Nokia N900.

Hi Pavel,

I tried to apply it here, but it seems that there are something
wrong with the patch:

$ quilt push -f --merge
Applying patch patches/lmml_50901_libv4l_make_libv4l2_usable_on_devices_with_complex_pipeline.patch
patching file lib/include/libv4l2.h
patching file lib/libv4l2/libv4l2-priv.h
patching file lib/libv4l2/libv4l2.c
Hunk #6 NOT MERGED at 1830-1857.
misordered hunks! output would be garbled
Hunk #7 FAILED at 1224.
Hunk #8 NOT MERGED at 1858-2057.
1 out of 8 hunks FAILED -- saving rejects to file lib/libv4l2/libv4l2.c.rej
patching file lib/libv4lconvert/control/libv4lcontrol.c
Applied patch patches/lmml_50901_libv4l_make_libv4l2_usable_on_devices_with_complex_pipeline.patch (forced; needs refresh)

I even tried to reset the tree to a patchset earlier than July, 8.
Same issue.

I could manually try to fix it, but that misordered hunks
warning is weird. Makes me wonder if the patch is not mangled.

Could you please re-send it on the top of upstream? Better to use
git send-email, as it won't mangle your patch.

Alternatively, please send me a ssh public key in private, and I'll
give you access to the repository where you can store those patches.

Thanks!
Mauro



Thanks,
Mauro
