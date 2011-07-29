From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 08/13] OMAP2+: powerdomain: control power domains next state
Date: Fri, 29 Jul 2011 10:47:43 +0200
Message-ID: <CAORVsuV68JhpV5XzXNV3Z9xxRUBbgDen7NDRG+h=in7-ZL=JhQ@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-9-git-send-email-j-pihet@ti.com>
	<20110729075942.GA26959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58249 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab1G2Iro convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 04:47:44 -0400
Received: by qwk3 with SMTP id 3so1724414qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 01:47:43 -0700 (PDT)
In-Reply-To: <20110729075942.GA26959@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

Todd,

On Fri, Jul 29, 2011 at 9:59 AM, Todd Poynor <toddpoynor@google.com> wr=
ote:
> On Thu, Jul 28, 2011 at 10:30:15AM +0200, jean.pihet@newoldbits.com w=
rote:
> ...
>> +int pwrdm_set_wkup_lat_constraint(struct powerdomain *pwrdm, void *=
cookie,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 long m=
in_latency)
>> +{
>> + =A0 =A0 struct pwrdm_wkup_constraints_entry *user =3D NULL;
>> + =A0 =A0 struct pwrdm_wkup_constraints_entry *tmp_user, *new_user;
>> + =A0 =A0 int ret =3D 0, free_new_user =3D 0, free_node =3D 0;
>> + =A0 =A0 long value =3D 0;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 pr_debug("powerdomain: %s: pwrdm %s, cookie=3D0x%p, min_la=
tency=3D%ld\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, cookie, min_late=
ncy);
>> +
>> + =A0 =A0 new_user =3D kzalloc(sizeof(struct pwrdm_wkup_constraints_=
entry),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>> + =A0 =A0 if (!new_user) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: FATAL ERROR: kzalloc failed\n"=
, __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
>> +
>> + =A0 =A0 /* Check if there already is a constraint for cookie */
>> + =A0 =A0 plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head=
, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (tmp_user->cookie =3D=3D cookie) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D tmp_user;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_new_user =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (min_latency !=3D PM_QOS_DEV_LAT_DEFAULT_VALUE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* If nothing to update, job done */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (user && (user->node.prio =3D=3D min_la=
tency))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ok;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Add new entry to the li=
st */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D new_user;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->cookie =3D cookie;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Update existing entry *=
/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, &pw=
rdm->wkup_lat_plist_head);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_node_init(&user->node, min_latency);
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_add(&user->node, &pwrdm->wkup_lat_pl=
ist_head);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Remove the constraint from the list */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: no prio=
r constraint to release\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, &pwrdm->wkup_lat_pl=
ist_head);
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_node =3D 1;
>
> All min_latency !=3D PM_QOS_DEV_LAT_DEFAULT_VALUE paths need
> free_new_user =3D 1.
free_new_user =3D 1 is only needed if no existing constraint has been
found, i.e. user stays at NULL. This is implemented in the check for
an existing constraint (plist_for_each_entry(...)).

>(Or maybe change the logic to check user !=3D
> new_user and free new_user if so.)
That could be done as well.

>
>> + =A0 =A0 }
>> +
>> +exit_ok:
>> + =A0 =A0 /* Find the strongest constraint from the list */
>> + =A0 =A0 if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
>> + =A0 =A0 =A0 =A0 =A0 =A0 value =3D plist_first(&pwrdm->wkup_lat_pli=
st_head)->prio;
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags)=
;
>> +
>> + =A0 =A0 if (free_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(user);
>> +
>> + =A0 =A0 if (free_new_user)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(new_user);
>> +
>> + =A0 =A0 /* Apply the constraint to the pwrdm */
>> + =A0 =A0 pr_debug("powerdomain: %s: pwrdm %s, value=3D%ld\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, value);
>> + =A0 =A0 pwrdm_wakeuplat_update_pwrst(pwrdm, value);
>> +
>> + =A0 =A0 return 0;
>> +
>> +exit_error:
>> + =A0 =A0 spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags)=
;
>
> Need:
> =A0 =A0 =A0 =A0kfree(new_user);
Correct!
BTW I have a new version (patch here below) that improves the cases
with latency =3D PM_QOS_DEV_LAT_DEFAULT_VALUE. This will come in v4
after testing.

>
>> + =A0 =A0 return ret;
>> +}
>
>
> Todd
>

Thanks for reviewing!

Regards,
Jean

---
Patch for cases with latency =3D PM_QOS_DEV_LAT_DEFAULT_VALUE:

diff --git a/arch/arm/mach-omap2/powerdomain.c
b/arch/arm/mach-omap2/powerdomain.c
index c0f48ab..2e9379b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -206,7 +206,7 @@ static int _pwrdm_post_transition_cb(struct
powerdomain *pwrdm, void *unused)
  * pwrdm_wakeuplat_update_pwrst - Update power domain power state if n=
eeded
  * @pwrdm: struct powerdomain * to which requesting device belongs to.
  * @min_latency: the allowed wake-up latency for the given power domai=
n. A
- *  value of 0 means 'no constraint' on the pwrdm.
+ *  value of PM_QOS_DEV_LAT_DEFAULT_VALUE means 'no constraint' on the=
 pwrdm.
  *
  * Finds the power domain next power state that fulfills the constrain=
t.
  * Programs a new target state if it is different from current power s=
tate.
@@ -232,7 +232,7 @@ static int pwrdm_wakeuplat_update_pwrst(struct
powerdomain *pwrdm,

 	/* Find power state with wakeup latency < minimum constraint */
 	for (new_state =3D 0x0; new_state < PWRDM_MAX_PWRSTS; new_state++) {
-		if (min_latency =3D=3D 0 ||
+		if (min_latency =3D=3D PM_QOS_DEV_LAT_DEFAULT_VALUE ||
 		    pwrdm->wakeup_lat[new_state] <=3D min_latency)
 			break;
 	}
@@ -1018,8 +1018,8 @@ int pwrdm_post_transition(void)
  * @pwrdm: struct powerdomain * which the constraint applies to
  * @cookie: constraint identifier, used for tracking.
  * @min_latency: minimum wakeup latency constraint (in microseconds) f=
or
- *  the given pwrdm. The value of PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE
- *  removes the constraint.
+ *  the given pwrdm. The value of PM_QOS_DEV_LAT_DEFAULT_VALUE removes
+ *  the constraint.
  *
  * Tracks the constraints by @cookie.
  * Constraint set/update: Adds a new entry to powerdomain's wake-up la=
tency
@@ -1042,7 +1042,7 @@ int pwrdm_set_wkup_lat_constraint(struct
powerdomain *pwrdm, void *cookie,
 	struct pwrdm_wkup_constraints_entry *user =3D NULL;
 	struct pwrdm_wkup_constraints_entry *tmp_user, *new_user;
 	int ret =3D 0, free_new_user =3D 0, free_node =3D 0;
-	long value =3D 0;
+	long value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE;
 	unsigned long flags;

 	pr_debug("powerdomain: %s: pwrdm %s, cookie=3D0x%p, min_latency=3D%ld=
\n",
@@ -1083,16 +1083,17 @@ int pwrdm_set_wkup_lat_constraint(struct
powerdomain *pwrdm, void *cookie,
 		plist_node_init(&user->node, min_latency);
 		plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
 	} else {
-		/* Remove the constraint from the list */
-		if (!user) {
-			pr_err("%s: Error: no prior constraint to release\n",
-			       __func__);
+		if (user) {
+			/* Remove the constraint from the list */
+			plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
+			free_node =3D 1;
+		} else {
+			/* Constraint not existing or list empty, do nothing */
+			free_new_user =3D 1;
 			ret =3D -EINVAL;
 			goto exit_error;
 		}

-		plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
-		free_node =3D 1;
 	}

 exit_ok:
@@ -1117,6 +1118,10 @@ exit_ok:

 exit_error:
 	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
+
+	if (free_new_user)
+		kfree(new_user);
+
 	return ret;
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
