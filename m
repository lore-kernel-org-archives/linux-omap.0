From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: cross compiling for OMAP2430
Date: Tue, 17 Apr 2007 09:45:14 -0500
Message-ID: <782515bb0704170745h123791d7q810869d2449d1cd5@mail.gmail.com>
References: <57314e840704170651r298a4a7fl89a121c380828f18@mail.gmail.com>
	<B62D67BD8EC3324C8A3DACEEA1A0D6C6012B8BE6@dlee12.ent.ti.com>
	<57314e840704170729if692d75h7a5229c7ebd7b136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <57314e840704170729if692d75h7a5229c7ebd7b136@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Budhee,
On 4/17/07, Budhee Jamaich <budheej@gmail.com> wrote:
> My company actually bought these two books... still.. I cannot understand
> why arm-linux-gcc is needed - can't standard gcc compile for the ARM ?
> doesn't gcc have arm code-generator back-end ?
> I cannot find this in google...
good place to ask: http://vger.kernel.org/vger-lists.html#linux-gcc

Further, from my brief understanding: it depends on the gcc
distribution you use, each have thier own "pet" patches applied and
may not support all platforms, for example, my RH Fedora5 PC has gcc
v4.1.1, but if i do a "-dumpmachine" it tells me:i386-redhat-linux.
the codesourcery's gcc distrib tells me "arm-none-linux-gnueabi"
Imagine a single gcc distribution supporting ARM,PPC,i386,i686 and all
other numerous versions (dont forget micro-controller ports)... it
will be huge and completely un-necessary in 90% of users. yes, the
backend generator is used for each port providing a uniform interface
for all platforms, but packaging it together.. it depends on the
target audience.

Further, the kernel is also tied with stable version of gcc, so
sometimes, using the old gcc versions or the bleeding edge gcc might
not work..

Regards,
Nishanth Menon
