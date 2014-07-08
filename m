From: =?windows-1252?Q?Kristina_Mart=9Aenko?=
 <kristina.martsenko@gmail.com>
Subject: Re: Anybody working on tidspbridge?
Date: Tue, 08 Jul 2014 15:48:21 +0300
Message-ID: <53BBE895.4020105@gmail.com>
References: <53A4569B.70604@gmail.com> <53A45BBD.4040201@gmail.com>
 <20140629164250.GA31625@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140629164250.GA31625@kroah.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Nishanth Menon <nm@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ernesto Ramos Falcon <ernesto@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Phil Carmody <ext-phil.2.carmody@nokia.com>, Shivananda Hebbar <x0hebbar@ti.com>, devel@driverdev.osuosl.org, Ramesh Gupta <grgupta@ti.com>, Suman Anna <s-anna@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>
List-Id: linux-omap@vger.kernel.org

On 29/06/14 19:42, Greg KH wrote:
> On Fri, Jun 20, 2014 at 07:05:17PM +0300, Kristina Mart=9Aenko wrote:
>> On 20/06/14 18:43, Kristina Mart=9Aenko wrote:
>>> Hi Omar,
>>>
>>> I'm helping Greg do a bit of cleanup in the staging tree. I noticed that
>>> nobody seems to have worked towards moving tidspbridge out of staging in
>>> over a year. Are there any plans to clean it up and move it out soon?
>>> Because otherwise we're going to have to delete the driver, as we don't
>>> want staging to become a permanent place for unfinished code.
>>>
>>> Thanks,
>>> Kristina
>>
>> Omar's email address in tidspbridge's TODO file seems to be outdated.
>> Resending to more recent addresses which hopefully won't bounce.
> =

> Given the total lack of response here, I suggest just deleting the
> driver.  No one has ever done the "real work" that is going to be
> required to get this code out of staging.  It has had build errors
> causing it to not even be usable for some kernel versions with no one
> noticing, so I doubt anyone cares about it anymore here.

Cc'ing some more people who might be interested. If no one offers to
work on the driver in the next couple of days, I'll send a patch to
remove it.

Kristina
