From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/2] OMAP: PM: switch from omap_pm_ functions
	to PM QoS
Date: Wed, 14 Dec 2011 15:57:38 +0100
Message-ID: <CAORVsuV5k997FWCHHibsxJS7sEsN2pB9b8GQbKGNemJNBJmSbg@mail.gmail.com>
References: <1319034531-22964-1-git-send-email-j-pihet@ti.com>
	<CAORVsuU3_+653sUMZUWrJ+QHgaWEDqZAy0kEv_o=5m8zfeS4dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuU3_+653sUMZUWrJ+QHgaWEDqZAy0kEv_o=5m8zfeS4dw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Paul, Kevin,

This patch series is depending on the latest constraints stuff for
OMAP [1], which has been reviewed by Kevin.

[1] http://marc.info/?l=3Dlinux-omap&m=3D132387443205028&w=3D2

Regards,
Jean

On Mon, Dec 12, 2011 at 5:27 PM, Jean Pihet <jean.pihet@newoldbits.com> wro=
te:
> Hi Kevin, Paul,
>
> ping on this series
>
> Thanks,
> Jean
>
> On Wed, Oct 19, 2011 at 4:28 PM, =A0<jean.pihet@newoldbits.com> wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> . Convert the OMAP I2C driver to the PM QoS API for MPU latency constrai=
nts
>> . Remove the latency related functions from OMAP PM in favor of
>> =A0the generic per-device PM QoS API
>>
>>
>> Apply on top of the OMAP PM QoS patch set [1].
>> Based on the pm-qos branch of the linux-pm git tree (3.1.0-rc3), cf. [2].
>>
>> Tested on OMAP3 Beagleboard (ES2.x) with constraints on MPU, CORE, PER in
>> RETention and OFF modes.
>>
>> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/65971
>> [2] git://github.com/rjwysocki/linux-pm.git
>>
>>
>> Jean Pihet (2):
>> =A0OMAP: convert I2C driver to PM QoS for latency constraints
>> =A0OMAP: PM: remove the latency related functions from the API
>>
>> =A0Documentation/arm/OMAP/omap_pm =A0 =A0 =A0 =A0 =A0 =A0| =A0 55 +++---=
----------
>> =A0arch/arm/plat-omap/i2c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 20 =
------
>> =A0arch/arm/plat-omap/include/plat/omap-pm.h | =A0 99 ------------------=
-----------
>> =A0arch/arm/plat-omap/omap-pm-noop.c =A0 =A0 =A0 =A0 | =A0 88 ----------=
---------------
>> =A0drivers/i2c/busses/i2c-omap.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 30 +++++-=
----
>> =A0include/linux/i2c-omap.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
>> =A06 files changed, 24 insertions(+), 269 deletions(-)
>>
>> --
>> 1.7.4.1
>>
