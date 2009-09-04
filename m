From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 3/4] dspbridge: use linux memory allocator directly
Date: Fri, 04 Sep 2009 14:02:02 +0300
Message-ID: <4AA0F3AA.5070606@gmail.com>
References: <1252055941-29745-1-git-send-email-andy.shevchenko@gmail.com> <1252055941-29745-2-git-send-email-andy.shevchenko@gmail.com> <1252055941-29745-3-git-send-email-andy.shevchenko@gmail.com> <1252055941-29745-4-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57359 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748AbZIDLCN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:02:13 -0400
In-Reply-To: <1252055941-29745-4-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap@vger.kernel.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Nice cleanups of the cra^H^Hode now one cared about!

:-)

On 09/04/2009 12:19 PM, Andy Shevchenko wrote:
>   #define LST_ELEM            list_head
> @@ -85,9 +85,9 @@ struct LST_LIST {
>   static inline struct LST_LIST *LST_Create(void)
>   {
>   	struct LST_LIST *pList;
> +	gfp_t flags =3D (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL;
>
> -	pList =3D (struct LST_LIST *) MEM_Calloc(sizeof(struct LST_LIST),
> -		MEM_NONPAGED);
> +	pList =3D kzalloc(sizeof(*pList), flags);
>   	if (pList !=3D NULL)
>   		INIT_LIST_HEAD(&pList->head);

Would be nice to kill this whole function as well.
 =20

> @@ -116,8 +116,7 @@ static inline struct LST_LIST *LST_Create(void)
>    */
>   static inline void LST_Delete(struct LST_LIST *pList)
>   {
> -	if (pList !=3D NULL)
> -		MEM_Free(pList);
> +	kfree(pList);
>   }

I guess whole 'LST_Delete()' could go away as well?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
