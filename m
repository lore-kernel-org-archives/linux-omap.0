From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: omapzoom isn't working again
Date: Sun, 31 Aug 2008 16:32:01 +0300
Message-ID: <94a0d4530808310632i42144b58v70e905e640bdca62@mail.gmail.com>
References: <20080830114046.GD14130@frodo>
	 <FCCFB4CDC6E5564B9182F639FC356087022A166BD4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:46947 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758221AbYHaNcB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 09:32:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1471399rvb.1
        for <linux-omap@vger.kernel.org>; Sun, 31 Aug 2008 06:32:01 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087022A166BD4@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Aug 31, 2008 at 2:53 PM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe
>> Balbi
>> Sent: Saturday, August 30, 2008 5:11 PM
>> To: linux-omap@vger.kernel.org
>> Subject: omapzoom isn't working again
>>
>> Tried cloning right and it's not working again.
>
> I have been able to clone the tree immediately after the last update.
>
>>
>> someone has to run git update-server-info.
>
> This was already done on last update.
>
>> chmod +x .git/hooks/post-update would be cooler though.
>
> Done this now. You can check. Maybe this step is also needed.

You need to do update-server-info each time there's a change at the
repository, that's why the post-update hook was recommended.

Now you have the hook, but nothing will change until the next update,
so do a update-server-info manually once to get the missing changes
immediately.

Best regards.

-- 
Felipe Contreras
