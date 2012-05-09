From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] OMAP: mailbox initial device tree support
Date: Wed, 9 May 2012 18:48:31 -0500
Message-ID: <CALLhW=5u75kSU1gorxMga2XHp4fbZnBBJhicTKGUCSTH86nAww@mail.gmail.com>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
	<B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA68F6D-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Vaibhav,

Somehow I missed this mail.

On 2 May 2012 00:42, Bedia, Vaibhav <vaibhav.bedia-l0cyMroinI0@public.gmane.org> wrote:
> Hi Omar,
>
> On Tue, May 01, 2012 at 23:17:38, Omar Ramirez Luna wrote:
>> To allow mailbox driver to function with device tree.
>>
>> Tested in OMAP4 and OMAP3. OMAP2 untested.
>>
>
> I think the mailbox code needs a cleanup similar to what you
> had proposed earlier [1] before the device tree support is added.

I believe the cleanup needs to be there, but this is generic enough to
support DT as it is.

> We probably need to decide whether the number of mailbox sub-modules
> should be part of hwmod attribute or come from device tree.

All the data is currently coming from hwmod, so I don't see why this
must be split now between hwmod and DT, but I'm open for suggestions.

> IMO the
> static allocation of the mailboxes is better suited in the device-tree
> data.

If possible I wouldn't want to tie use case specifics to DT or hwmod,
the whole point for the cleanup was to allow a dynamic mailbox
allocation and not statically assign them.

Regards,

Omar
