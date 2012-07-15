From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] remoteproc: remove the get_by_name/put API
Date: Sun, 15 Jul 2012 13:11:46 +0300
Message-ID: <CAK=WgbZ7ZoVqniJzfXXvq1krUWanteB73J=28GstnFmpWGHfvw@mail.gmail.com>
References: <1341259857-17382-1-git-send-email-ohad@wizery.com> <4FF335E3.5040509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FF335E3.5040509@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>, Loic Pallardy <loic.pallardy@stericsson.com>, Ludovic BARRE <ludovic.barre@stericsson.com>, Michal Simek <monstr@monstr.eu>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Suman Anna <s-anna@ti.com>, Mark Grosen <mgrosen@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 3, 2012 at 9:11 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/02/12 13:10, Ohad Ben-Cohen wrote:
>> Remove rproc_get_by_name() and rproc_put(), and the associated
>> remoteproc infrastructure that supports it (i.e. klist and friends),
>> because:
>>
>> 1. No one uses them
>> 2. Using them is highly discouraged, and any potential user
>>    will be deeply scrutinized and encouraged to move.
>>
>> If a user, that absolutely can't live with the direct boot/shutdown
>> model, does show up one day, then bringing this functionality back
>> is going to be trivial.
>>
>> At this point though, keeping this functionality around is way too
>> much of a maintenance burden.
>>
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, applied.
