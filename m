From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH/RESEND 9/9] drm/tilcdc: replace late_initcall with
 module_init
Date: Wed, 25 Jun 2014 14:00:42 +0100
Message-ID: <20140625130042.GK3705@n2100.arm.linux.org.uk>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
 <53A9F5F4.3030806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <53A9F5F4.3030806@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Darren Etheridge <detheridge@ti.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 24, 2014 at 05:04:36PM -0500, Darren Etheridge wrote:
> On 06/17/2014 09:17 AM, Guido Mart=EDnez wrote:
>> Use module_init instead of late_initcall, as is the norm for modular
>> drivers.
>>
>> module_init was used until 6e8de0bd6a51fdeebd5d975c4fcc426f730b339b
>> ("drm/tilcdc: add encoder slave (v2)") changed it to a late_initcall,
>> but it does not explain why. Tests show it's working properly with
>> module_init.
>>
>
> If I recall, the late_initcall stuff was done to try and make sure the  =

> tda998x/i2c subsystem came up before tilcdc. However it didn't always  =

> work so we added commit: 39de6194131c155901f96686a063212656d80c2e to try  =

> and ensure the ordering.  This might be why changing back to module_init  =

> is fine (and I agree with your assessment from my testing).

There's a solution to that... I have patches which convert the tda998x
driver to also register into the component helpers as well as remaining
as a drm slave device.  This makes it possible to transition tilcdc to
use the component helper to solve the initialisation ordering.

I'll (re-)post them later today.

-- =

FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
