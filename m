From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] PM/AVS: SmartReflex: fix fake probe success on debugfs fail
Date: Wed, 16 Oct 2013 09:43:01 -0500
Message-ID: <CAGo_u6rNJyzxtxn=0o-RC4487O+QuL5xE+vb+sP8_QxMg7g4yw@mail.gmail.com>
References: <1381923650-7556-1-git-send-email-manishv.b@ti.com>
	<525E9380.7090905@ti.com>
	<CAKDJKT7W-1S_KzZ5XEYJQuMnQEu17xbRjeNmZgj=-73Z0Kz_Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAKDJKT7W-1S_KzZ5XEYJQuMnQEu17xbRjeNmZgj=-73Z0Kz_Qg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, khilman@kernel.org, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 16, 2013 at 9:24 AM, Manish Badarkhe
<badarkhe.manish@gmail.com> wrote:
>
>>
>> IMHO, fail of creation of debugfs is not reason enough to fail the
>> probe - further, this code needs a major revamp to work with device tree.
>
> Yes, fail of debugfs creation should not be enough reason to fail probe. But as
> per current implementation of code, on debugfs failure smart reflex node is
> getting deleted and probe get failed. This patch not made any changes in
> logic of code but only makes proper use of  "IS_ERR_OR_NULL".

Thanks for the clarification, it was not obvious from the commit
message. Further, I would rather prefer to see a proper cleanup that
handles error completely, since IS_ERR_OR_NULL is not really
recommended anymore.
Regards,
Nishanth Menon
