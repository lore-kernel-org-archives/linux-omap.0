From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] OMAP3 : PM : Handle variable length OPP tables
Date: Wed, 30 Sep 2009 11:13:39 -0700
Message-ID: <636c5030909301113k2743c1dbpceafb07444e59fbf@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C43CA@dbde02.ent.ti.com>
	 <87ljjwmhgp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:33905 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZI3SNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 14:13:35 -0400
Received: by pxi32 with SMTP id 32so5686963pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 11:13:39 -0700 (PDT)
In-Reply-To: <87ljjwmhgp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Sep 30, 2009 at 11:10 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Premi, Sanjeev" <premi@ti.com> writes:
>
>> Hi all,
>>
>> There is no generic function to translate an OPP to FREQ and vice ve=
rsa.
>> Came across the problem while trying to submit a follow-up to earlie=
r
>> patch for change in mpurate via bootargs.
>>
>> The function get_opp in resource34xx.c, but it is always called with=
 an
>> explicit addition of MAX_VDDn_OPP e.g.
>>
>> =A0 opp =3D get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
>> =A0 opp =3D get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);
>>
>> This is 'addition' is required as there is no encapsulation of the
>> MIN and MAX VDDs associated to the table.
>>
>> The patch below fixes this issue; buy creating a 'table' object with
>> necessary information. It can also help in getting rid of the
>> empty {0, 0, 0} at index 0 of each OPP table.
>>
>> At the moment, it does not break any functionality in resource34xx.c=
;
>> migration to this encapsulation can be taken as next step.
>>
>> This code is bare 'git-diff' for early comments. Formal patch to fol=
low...
>
> Looks ok. =A0Please send updated patch against current PM branch.

oops, please ignore.  I see you already posted a patch.  Will comment t=
here.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
