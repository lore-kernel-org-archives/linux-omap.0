From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
Date: Wed, 7 Sep 2011 18:23:10 +0530
Message-ID: <CAC83ZvKjCCFPOqP9pBF=4bmz+cPhUna2BaYR9jbJzWN_WPT+YQ@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
	<CAC83Zv+sX1G4saFsU=bOUYjedcM6eYEOCVMKqMZ-5pxkBc6x2A@mail.gmail.com>
	<87sjo8ttwf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87sjo8ttwf.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 7, 2011 at 6:02 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> [...]
>>>> + =A0 =A0 /*
>>>> + =A0 =A0 =A0* If this is the first gpio_request for the bank,
>>>> + =A0 =A0 =A0* enable the bank module.
>>>> + =A0 =A0 =A0*/
>>>> + =A0 =A0 if (!bank->mod_usage)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR_VALUE(pm_runtime_get_sync(bank->d=
ev) < 0)) {
>>>
>>> All of the IS_ERR_VALUE() usage is wrong here. =A0You're checking if the
>>> result of IS_ERR_VALUE() is < 0 which will never happen.
>> No.
>> IS_ERR_VALUE is applied on the return value of pm_runtime_get_sync
>> which is < =A00.
>
> ...and is still not correct.
>
> The result of the '< 0' check will be zero or one, so IS_ERR_VALUE()
> will never be true.
Ok.

>
> Kevin
>
