From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH 1/8] staging: tidspbridge: overwrite DSP error codes
Date: Wed, 3 Nov 2010 18:34:44 -0600
Message-ID: <AANLkTikAS0oHpGLYesoXa8YMpOwV4e8M3f7ZEhbrm4b9@mail.gmail.com>
References: <1288827394-7505-1-git-send-email-rene.sapiens@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1288827394-7505-1-git-send-email-rene.sapiens@ti.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: greg@kroah.com
Cc: nm@ti.com, devel@driverdev.osuosl.org, felipe.contreras@gmail.com, gregkh@suse.de, ernesto@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Rene Sapiens <rene.sapiens@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 3, 2010 at 5:36 PM, Rene Sapiens <rene.sapiens@ti.com> wrote:
> When calling the DSP's remote functions, the DSP returns error
> codes different from the ones managed by the kernel, the
> function's return value is shared with the MPU using a shared
> structure. This patch overwrites those error codes by kernel
> specifics and deletes unnecessary code.
>

The series of patches that follow this one do not apply yet, so please omit this
patch, i will send it again as a single one.

Regards,
Rene
