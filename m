From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: cross compiling bluez-utils
Date: Thu, 10 May 2007 03:55:55 +0300
Message-ID: <57314e840705091755o16799a68n43737b811800dc48@mail.gmail.com>
References: <57314e840705091523k23527156wa47412fb452a0ce6@mail.gmail.com>
	<B62D67BD8EC3324C8A3DACEEA1A0D6C60161E370@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <B62D67BD8EC3324C8A3DACEEA1A0D6C60161E370@dlee12.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Kipisz, Steven" <s-kipisz2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Steven,

On 5/10/07, Kipisz, Steven <s-kipisz2@ti.com> wrote:
> I would suggest getting bluez-libs-2.10 and bluez-utils-2.10.
hmm.. can't find these... do you happen to know where they can be found ?

> The utils for 3.9 have more requirements than you really need.
>  A few weeks ago I was trying to
> cross-compile the utils for 3.9 or 3.10 (I cannot remember which) and
> they needed something that couldn't be cross-compiled without some
> configuration changes.

I tried today, utils 3.9 need dbus, but the dbus ./configure script
fails shouting it cannot do its tests in cross compiling mode...
in addition, the dbus need fortran (??) compiler, which i don't have
for arm...

I don't even know if I really want this dbus on OMAP. it sounds like
this dbus will take too much memory....

the question is whether bluez 2.1 will work under kernel 2.6.10 ?

Thank You
budhee
