From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH] tools: iio: fix iio build error by adding KBUILD_OUTPUT
 support to makefile
Date: Fri, 16 Sep 2016 10:56:33 +0530
Message-ID: <b46a5beb-3998-bd98-d873-f822651b8657@ti.com>
References: <20160811060124.6604-1-mugunthanvnm@ti.com>
 <198eb20a-0150-b2b7-8b96-a4a13349724a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <198eb20a-0150-b2b7-8b96-a4a13349724a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Jonathan

On Monday 22 August 2016 12:35 AM, Jonathan Cameron wrote:
> On 11/08/16 07:01, Mugunthan V N wrote:
>> > Current make doesn't have support to pass kernel built directory
>> > to find events.h kernel header file, so adding support for
>> > KBUILD_OUTPUT support to Makefile.
>> > 
>> > $ make CROSS_COMPILE=arm-linux-gnueabihf- -C tools/iio
>> > make: Entering directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
>> > arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_event_monitor.o iio_event_monitor.c
>> > arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_utils.o iio_utils.c
>> > arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o lsiio.o lsiio.c
>> > arm-linux-gnueabihf-gcc -Wall -g -D_GNU_SOURCE   -c -o iio_generic_buffer.o iio_generic_buffer.c
>> > arm-linux-gnueabihf-gcc   lsiio.o iio_utils.o   -o lsiio
>> > arm-linux-gnueabihf-gcc   iio_generic_buffer.o iio_utils.o   -o iio_generic_buffer
>> > iio_event_monitor.c:28:30: fatal error: linux/iio/events.h: No such file or directory
>> >  #include <linux/iio/events.h>
>> >                                ^
>> > compilation terminated.
>> > <builtin>: recipe for target 'iio_event_monitor.o' failed
>> > make: *** [iio_event_monitor.o] Error 1
>> > make: Leaving directory '/home/a0131834/workspace/git/mainline/linux/tools/iio'
>> > 
>> > Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> I can see where you are coming from, but wouldn't we normally expect the kernel
> headers for the relevant kernel to available as part of the toolchain being
> used to do the build?

If it is a native build, we can expect toolchain to provide kernel
headers, but for a cross compile user has to provide where the kernel
headers present for the target which is done this patch.

> 
> They often lag a bit I guess, so perhaps we do want to put this little bit
> of 'fudging' in place.
> 
> What do others think?

Any updates on the patch?

Regards
Mugunthan V N
